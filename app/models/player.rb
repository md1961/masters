class Player < ActiveRecord::Base
  has_many :clubs
  has_many :score_cards
  has_one :grouping
  has_one :group, through: :grouping
  has_one :round, through: :group
  has_one :ball
  has_one :shot, through: :ball
  #has_one :area, through: :shot

  attr_accessor :info

  def play_order
    grouping.play_order
  end

  # TODO: Remove argument hole_number.
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
    ball.save!
    @info
  end

  def swing_club
    club = clubs.find_by(name: ball.next_use.downcase)
    result = club.swing(ball.next_adjust)
    @info = club.info
    if result == '(1)' && ball.next_adjust == 0
      max_roll_for_in = 3 + (ball.superlative? ? 1 : 0)
      dice = Dice.roll
      result = dice <= max_roll_for_in ? 'IN' : '1'
      @info += ", '#{result}' from dice '#{dice}'"
    elsif ball.superlative? && result.to_i > 0 && !shot.is_layup
      dice = Dice.roll
      result = (result.to_i - dice).abs.to_s
      result = 'IN' if result == '0'
      @info += ", '#{result}' from dice '#{dice}' after superlative"
    end
    result
  end

  def to_s
    "#{last_name}" #, #{first_name}"
  end
end
