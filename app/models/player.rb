class Player < ActiveRecord::Base
  has_many :clubs
  has_many :invitations
  has_many :tournaments, through: :invitations
  has_many :score_cards, -> { order(:round_id) }
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

  def tournament_rounds(round_number_upto: 999999)
    round.tournament.rounds.where('number <= ?', round_number_upto).order(:number)
  end

  def tournament_score_cards(round_number_upto: 999999)
    score_cards.where(round: tournament_rounds(round_number_upto: round_number_upto))
  end

  def tournament_stroke(round_number_upto: 999999)
    return nil if score_cards.empty?
    tournament_score_cards(round_number_upto: round_number_upto).map(&:total_value).sum
  end

  def tournament_score(round_number_upto: 999999)
    return nil if score_cards.empty?
    rounds = tournament_rounds(round_number_upto: round_number_upto)
    total_par = tournament_score_cards(round_number_upto: round_number_upto).map(&:total_par).sum
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
      number >= 18 ? 'F' : number.zero? ? '-' : number.to_s
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

  def full_name
    "#{last_name}, #{first_name}"
  end

  def to_s
    last_name
  end

  private

    def swing_club
      club = clubs.find_by(name: ball.next_use.downcase)
      ball.club_used = club
      result = club.swing(ball.next_adjust, max_distance: shot.hole.max_distance_of_green)
      make_par_3_tee_shot_superlative(ball)
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
      result = adjust_distance_on_green(result, club)
      result
    end

    MAX_DICE_TO_CH_TO_GREEN_ON_14 = 3

    def adjust_distance_on_green(result, club)
      return result if shot.hole.number != 14
      if result.to_i > 0
        @info += ", '#{result}' is multiplied by 1.5"
        suffix = result.sub(/\A\d+/, '')
        (result.to_i * 1.5).floor.to_s + suffix
      elsif result.end_with?('Ch') && Dice.roll <= MAX_DICE_TO_CH_TO_GREEN_ON_14
        @info += ", '#{result}' is changed onto green"
        rand(50 .. 80).to_s
      else
        result
      end
    end

    def make_par_3_tee_shot_superlative(ball)
      return unless shot.hole.par == 3 && shot.number == 1
      drive_result = clubs.find_by(name: 'drive').swing
      ball.result = '*' if drive_result.end_with?('*')
    end

    def write_score
      score_card = score_cards.find_or_create_by(round: round)
      score = score_card.scores.find_or_create_by(hole: shot.hole)
      score.update!(value: ball.shot_count)
    end
end
