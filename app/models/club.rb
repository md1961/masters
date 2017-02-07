class Club < ActiveRecord::Base
  has_many :club_results
  belongs_to :player


  # TODO: Move to somewhere else.
  def self.two_dices
    d1 = rand(1 .. 6)
    d2 = rand(1 .. 6)
    d1, d2 = d2, d1 if d1 > d2
    d1 * 10 + d2
  end


  def putt?
    name == 'putt'
  end

  def swing
    result = club_results.find_by(dice: Club.two_dices).result
    if putt?
      ball_on = player.ball.result.to_i
      if player.ball.ok? || result.to_i >= ball_on
        result = 'IN'
      elsif result =~ /[A-D]\z/
        raise StandardError, "Second putt resolve not implemented yet."
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
