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
    result, is_layup = swing_club
    self.shot = shot.next(is_layup)
    shot_judge = shot.judge(result)
    ball.result = result
    ball.shot_count += 1
    save!
    shot_judge
  end

  def swing_club
    shot_judgement = ShotJudgement.new
    club = \
      if ball.ok? || ball.result.to_i > 0
        clubs.find_by(name: 'putt')
      else
        shot_judge = shot.judge(ball.result)
        shot_judgement = shot_judge.determine
        ball.shot_count += shot_judgement.shot_count_addend
        clubs.find_by(name: shot_judgement.club_name.downcase)
      end
    result = club.swing(shot_judgement.dice_adjust)
    if club.putt? && result.to_i >= ball.result.to_i
      result = 'IN'
    elsif result == '(1)' && shot_judgement.dice_adjust == 0
      max_roll_for_in = 3 + (ball.superlative? ? 1 : 0)
      result = Dice.roll <= max_roll_for_in ? 'IN' : '1'
    elsif ball.superlative? && result.to_i > 0
      result = (result.to_i - Dice.roll).abs
      result = 'IN' if result.zero?
    end
    [result, shot_judgement.is_layup]
  end

  def to_s
    "#{last_name}, #{first_name}"
  end
end
