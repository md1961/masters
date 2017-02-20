class Player < ActiveRecord::Base
  has_many :clubs
  has_many :invitations
  has_many :tournaments, through: :invitations
  has_many :score_cards
  has_one :grouping
  has_one :group, through: :grouping
  has_one :round, through: :group
  has_one :ball
  has_one :shot, through: :ball
  #has_one :area, through: :shot

  attr_accessor :info

  def finished_round?
    ball&.finished_round?
  end

  def play_order
    grouping.play_order
  end

  def tournament_stroke(round_number_upto: nil)
    round_number_upto = 9999 unless round_number_upto
    rounds = round.tournament.rounds.where('number <= ?', round_number_upto)
    score_cards.where(round: rounds).map(&:total_value).sum
  end

  def tournament_score(round_number_upto: nil)
    round_number_upto = 9999 unless round_number_upto
    rounds = round.tournament.rounds.where('number <= ?', round_number_upto)
    total_par = score_cards.where(round: rounds).map(&:total_par).sum
    tournament_stroke(round_number_upto: round_number_upto) - total_par
  end

  def leader_sorter
    [tournament_score, hole_finished_sorter]
  end

  def hole_finished
    if finished_round?
      'F'
    elsif ball.nil?
      '-'
    else
      number = shot.hole.number - (ball.holed_out? ? 0 : 1)
      number.zero? ? '-' : number.to_s
    end
  end

  def hole_finished_sorter
    h = hole_finished
    n = h == '-' ? -1 : h == 'F' ? 20 : h.to_i
    -n
  end

  def play(hole_number: 1, index_option: nil)
    if ball.try(:holed_out?)
      return
    elsif ball.try(:next_use_optional?)
      raise "Need to specify index_option for next_use of '#{ball.next_use}'" unless index_option
      raise "Illegal index_option of '#{index_option}' (0 or 1 required)" unless [0, 1].include?(index_option)
      ball.choose_next_use(index_option)
    end
    unless ball
      _shot = Shot.first_tee(hole_number)
      create_ball!(shot: _shot)
    end
    club_result = swing_club
    self.shot = shot.next(ball)
    ball.accept(club_result)
    ball.shot_count += 1
    write_score if ball.holed_out?
    ball.save!
    @info
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(Player)
    self.last_name == other.last_name && self.first_name == other.first_name
  end

  def to_s
    "#{last_name}" #, #{first_name}"
  end

  private

    def swing_club
      club = clubs.find_by(name: ball.next_use.downcase)
      ball.club_used = club
      result = club.swing(ball.next_adjust)
      @info = club.info
      if result == '(1)'
        max_roll_for_in = 3 + (ball.superlative? ? 1 : 0)
        dice = Dice.roll
        result = dice <= max_roll_for_in ? 'IN' : '1'
        @info += ", '#{result}' from dice #{dice}"
      elsif ball.superlative? && result.to_i > 0 && !shot.is_layup
        dice = Dice.roll
        result = (result.to_i - dice).abs.to_s
        result = 'IN' if result == '0'
        @info += ", '#{result}' from dice #{dice} after superlative"
      end
      result
    end

    def write_score
      score_card = score_cards.find_or_create_by(round: round)
      score = score_card.scores.find_or_create_by(hole: shot.hole)
      score.update!(value: ball.shot_count)
    end
end
