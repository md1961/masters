class Club < ActiveRecord::Base
  has_many :club_results
  belongs_to :player

  attr_reader :info

  def putt?
    name == 'putt'
  end

  def swing(dice_adjust = 0)
    dice = Dice.two_rolls
    @info = "'#{dice}'"
    unless dice_adjust.zero?
      dice = dice_adjusted(dice, dice_adjust)
      @info = "'#{dice}'(#{format("%+d", dice_adjust)} of #{@info})"
    end
    result = club_results.find_by(dice: dice).result
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
    @info = "'#{result}' by #{self} on dice #{@info}"
    result
  end

  def to_s
    name =~ /[wi]\z/ ? name.upcase : name.capitalize
  end

  private

    def dice_adjusted(dice, adjust)
      binding.pry
      @@dices ||= club_results.pluck(:dice).sort
      index = @@dices.index(dice)
      raise StandardError, "No dice '#{dice}' in ClubResult of #{club} of #{player}" unless index
      index += adjust
      index =  0 if index < 0
      index = -1 if index >= @@dices.size
      @@dices[index]
    end
end
