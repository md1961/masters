class Player < ActiveRecord::Base
  has_many :clubs
  has_many :groupings
  has_many :groups, through: :groupings
  has_one :ball
  has_one :shot, through: :ball

  # TODO: Remove argument hole_number.
  def play(hole_number = 1)
    if ball.try(:holed_out?)
      hole_number = shot.hole.number + 1
      ball.destroy
      reload
    end
    unless ball
      _shot = Shot.first_tee(hole_number)
      create_ball!(shot: _shot)
    end
    result = swing_club
    self.shot = shot.next(ball.is_layup)
    ball.accept(result)
    ball.shot_count += 1
    save!
    ball
  end

  def swing_club
    club = clubs.find_by(name: ball.next_use.downcase)
    result = club.swing(ball.next_adjust)
    if club.putt? && result.to_i >= ball.result.to_i
      result = 'IN'
    elsif result == '(1)' && ball.next_adjust == 0
      max_roll_for_in = 3 + (ball.superlative? ? 1 : 0)
      result = Dice.roll <= max_roll_for_in ? 'IN' : '1'
    elsif ball.superlative? && result.to_i > 0
      result = (result.to_i - Dice.roll).abs
      result = 'IN' if result.zero?
    end
    result
  end

  def to_s
    "#{last_name}, #{first_name}"
  end
end
