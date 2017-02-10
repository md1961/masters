class Player < ActiveRecord::Base
  has_many :clubs
  has_many :groupings
  has_many :groups, through: :groupings
  has_one :ball
  has_one :shot, through: :ball

  attr_accessor :info

  # TODO: Remove argument hole_number.
  def play(hole_number: 1, index_option: nil)
    if ball.try(:next_use_optional?)
      raise "Need to specify index_option for next_use of '#{ball.next_use}'" unless index_option
      raise "Illegal index_option of '#{index_option}' (0 or 1 required)" unless [0, 1].include?(index_option)
      ball.choose_next_use(index_option)
    elsif ball.try(:holed_out?)
      hole_number = shot.hole.number + 1
      end_of_round if hole_number > 18
      ball.destroy
      reload
    end
    unless ball
      _shot = Shot.first_tee(hole_number)
      create_ball!(shot: _shot)
    end
    club_result = swing_club
    self.shot = shot.next(ball.is_layup)
    ball.accept(club_result)
    ball.shot_count += 1
    save!
    ball.to_s + "\n#{@info}"
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
    "#{last_name}, #{first_name}"
  end
end
