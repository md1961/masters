class Player < ActiveRecord::Base
  has_many :clubs
  has_many :groupings
  has_many :groups, through: :groupings
  has_one :ball
  has_one :shot, through: :ball

  # TODO: Remove argument hole_number.
  def play(hole_number = 1)
    return if ball.try(:holed_out?)
    create_ball!(shot: Shot.first_tee(hole_number)) unless ball
    result = swing_club
    self.shot = shot.next
    shot_judge = shot.judge(result)
    ball.result = result
    ball.shot_count += 1
    save!
    shot_judge
  end

  def swing_club
    result_adjust = 0
    club = \
      if ball.ok? || ball.result.to_i > 0
        clubs.find_by(name: 'putt')
      else
        shot_judge = shot.judge(ball.result)
        result_adjust = shot_judge.next_adjust
        clubs.find_by(name: shot_judge.next_club.downcase)
      end
    result = club.swing(result_adjust)
    result = 'IN' if club.putt? && result.to_i >= ball.result.to_i
    result
  end

  def to_s
    "#{last_name}, #{first_name}"
  end
end
