class Club < ActiveRecord::Base
  has_many :club_results
  belongs_to :player

  def putt?
    name == 'putt'
  end

  def swing
    result = club_results.find_by(dice: Dice.two_rolls).result
    if putt?
      ball_on = player.ball.result.to_i
      if player.ball.ok? || player.ball.third_putt? || result.to_i >= ball_on
        result = 'IN'
      elsif player.ball.second_putt?
        result = Dice.two_rolls == 11 ? '1t' : 'OK'
      elsif result =~ /[A-D]\z/
        suffix = Regexp.last_match(0)
        result = SecondPuttResult.get(ball_on, suffix)
      else
        result = 'OK'
      end
    end
    result
  end

  def to_s
    name
  end
end
