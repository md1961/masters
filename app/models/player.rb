class Player < ActiveRecord::Base
  has_many :clubs
  has_many :groupings
  has_many :groups, through: :groupings
  has_one :ball
  has_one :shot, through: :ball

  def play
    create_ball!(shot: Shot.first_tee) unless ball
    shot_judge = shot.judge(ball.result)
    club = clubs.find_by(name: shot_judge.next_club.downcase)
    result = club.swing
    ball.result = result
    self.shot = shot.next
    shot_judge = shot.judge(result)
    ball.shot_count += 1
    save!
    shot_judge
  end

  def to_s
    "#{last_name}, #{first_name}"
  end
end
