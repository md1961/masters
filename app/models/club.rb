class Club < ActiveRecord::Base
  has_many :club_results
  belongs_to :player

  attr_reader :info

  def putt?
    name == 'putt'
  end

  # TODO: Alter direction of Ch and P randomly.
  # TODO: Interpolate distance randomly.

  def swing(dice_adjust = 0)
    raise "Should not reach here: return 'IN'" if player.ball.ok?
    raw_dice = Dice.two_rolls
    if dice_adjust.zero?
      dice = raw_dice
      @info = "#{dice}"
    else
      dice = dice_adjusted(raw_dice, dice_adjust)
      @info = "#{dice}(#{format("%+d", dice_adjust)} of #{raw_dice})"
    end
    raw_result = club_results.find_by(dice: dice).result unless player.ball.third_putt?
    raw_result = add_random_direction(raw_result) if raw_result == 'Ch'
    result = raw_result
    info_add = nil
    if putt?
      ball_on = player.ball.result.to_i
      if player.ball.third_putt?
        result = dice == 11 ? 'OK' : 'IN'
      elsif raw_result == 'IN' || raw_result.to_i >= ball_on
        result = 'IN'
      elsif player.ball.second_putt?
        result = '1t'
      elsif raw_result =~ /[A-D]\z/
        suffix = Regexp.last_match(0)
        result = SecondPuttResult.get(ball_on, suffix)
      else
        result = 'OK'
      end
    elsif raw_result == '(1)' && raw_dice != 66
      result = '1'
      info_add = ", converted to '1' for modified dice 66"
    end
    @info = "'#{raw_result}' by #{self} on dice #{@info}" + (info_add ? info_add : '')
    result
  end

  def to_s
    name =~ /[wi]\z/ ? name.upcase : name.capitalize
  end

  private

    def dice_adjusted(dice, adjust)
      @@dices ||= club_results.pluck(:dice).sort
      index = @@dices.index(dice)
      raise StandardError, "No dice #{dice} in ClubResult of #{club} of #{player}" unless index
      index += adjust
      index =  0 if index < 0
      index = -1 if index >= @@dices.size
      @@dices[index]
    end

    def add_random_direction(raw_result)
      "#{%w(SL SC SR ML MR LL LC LR).sample}-#{raw_result}"
    end
end
