class Club < ApplicationRecord
  has_many :club_results
  belongs_to :player

  attr_reader :info

  VALID_NAMES = %w[drive fw li mi si p ch sd putt]

  validates :name, uniqueness: {scope: :player_id}, inclusion: {in: VALID_NAMES}
  validates :player, presence: true

  select(:name).uniq.pluck(:name).each do |club_name|
    define_method("#{club_name}?") { name == club_name }
  end

  MAX_DICE_TO_RANDOMIZE_DIRECTION  = 1
  MAX_DICE_TO_INTERPOLATE_DISTANCE = 2

  def swing(dice_adjust = 0, max_distance: nil)
    @info_add = ''
    raw_dice = Dice.two_rolls
    @index_dice_minus = 0
    if dice_adjust.zero?
      dice = raw_dice
      @info = "#{dice}"
    else
      dice = dice_adjusted(raw_dice, dice_adjust)
      @info = "#{dice}(#{format("%+d", dice_adjust)} of #{raw_dice})"
    end
    raw_result = club_results.find_by(dice: dice).result unless player.ball.third_putt?
    raw_result = add_random_direction(raw_result) if raw_result == 'Ch'
    result = interpolate_distance(raw_result, dice)
    if !putt? && max_distance && result.to_i > max_distance
      result = add_random_direction('Ch')
      @info_add << ", went off green with max_distance of '#{max_distance}'"
    elsif putt?
      ball_on = player.ball.result.to_i
      if player.ball.ok?
        result = 'IN'
      elsif player.ball.third_putt?
        result = dice <= 16 ? 'OK' : 'IN'
      elsif raw_result == 'IN' || raw_result.to_i >= ball_on
        result = 'IN'
      elsif player.ball.second_putt?
        result = dice <= 16 ? '1t' : 'OK'
      elsif raw_result =~ /[A-D]\z/
        suffix = Regexp.last_match(0)
        result = SecondPuttResult.get(ball_on, suffix)
        result = '1OK' if result == 'OK'
      else
        prefix = Dice.roll >= 3 ? '' : rand(1 .. 2).to_s
        result = prefix + 'OK'
      end
    elsif raw_result == '(1)' && raw_dice != 66
      result = '1'
      @info_add = ", converted to '1' for modified dice 66"
    elsif raw_result =~ /\A([SML][LRC])-(P|Ch)/
      dice = Dice.roll
      if @index_dice_minus < 0 || dice <= MAX_DICE_TO_RANDOMIZE_DIRECTION
        direction     = Regexp.last_match(1)
        result_suffix = Regexp.last_match(2)
        excludes = @index_dice_minus < 0 ? [] : [direction]
        result = add_random_direction(result_suffix, excludes)
        @info_add = ', direction converted ' \
          + (@index_dice_minus < 0 ? "for dice adjust exceeds by #{@index_dice_minus}" : "on dice #{dice}")
      end
    end
    @info = "'#{raw_result}' by #{self} on dice #{@info}" + @info_add
    result
  end

  def dice_list
    @@dices ||= club_results.empty? ? nil : club_results.pluck(:dice).sort
  end

  def stats
    @stats ||= make_stats
  end

  def stats_value
    stats.inject(0) { |sum, (stat_name, value)|
      sum += value * (stat_name == :green_hitting_distance ? -1 : 1)
    }
  end

  def ==(other)
    return false unless other && other.is_a?(self.class) && name == other.name
    result_values == other.result_values
  end

  def eql?(other)
    self == other
  end

  def hash
    result_values.hash
  end

  def result_values
    @result_values ||= club_results.order(:dice).map(&:result)
  end

  def copy_from(player_from)
    club_from = player_from.clubs.find_by(name: name)
    club_from.club_results.each do |club_result|
      club_results.find_or_create_by!(dice: club_result.dice).update!(result: club_result.result)
    end
  end

  def store_as_old
    OldClub.create!(player: player, name: name).tap { |old_club|
      club_results.each do |club_result|
        old_club.old_club_results.create!(dice: club_result.dice, result: club_result.result)
      end
    }
  end

  def to_s
    name =~ /(:?fw|[lms]i)\z/ ? name.upcase : name.capitalize
  end

  private

    def dice_adjusted(dice, adjust)
      index = dice_list.index(dice)
      raise StandardError, "No dice #{dice} in ClubResult of #{club} of #{player}" unless index
      index += adjust
      if index < 0
        @index_dice_minus = index
        index =  0
      elsif index >= dice_list.size
        index = -1
      end
      dice_list[index]
    end

    def add_random_direction(raw_result, excludes = [])
      excludes += %w(ML MR LL LC LR) if raw_result == 'P'
      directions = %w(SL SC SR ML MR LL LC LR).reject { |dir| excludes.include?(dir) }
      "#{directions.sample}-#{raw_result}"
    end

    RE_PURE_DIGITS = /\A\d+\z/

    def interpolate_distance(raw_result, dice)
      return raw_result unless raw_result =~ RE_PURE_DIGITS
      return raw_result if Dice.roll > MAX_DICE_TO_INTERPOLATE_DISTANCE
      dice_dir = Dice.roll
      direction = dice_dir <= 3 ? -1 : 1
      dice_adjacent = dice_list[dice_list.index(dice) + direction]
      raw_result_adjacent = club_results.find_by(dice: dice_adjacent)&.result
      if raw_result_adjacent =~ RE_PURE_DIGITS && (raw_result.to_i - raw_result_adjacent.to_i).abs >= 2
        half_distance = (raw_result_adjacent.to_i + raw_result.to_i) / 2
        selection_range = \
          if raw_result.to_i < half_distance
            (raw_result.to_i + 1 .. half_distance)
          else
            (half_distance .. raw_result.to_i - 1)
          end
        result = selection_range.to_a.sample.to_s
        @info_add = ", interpolated to '#{result}' from '#{raw_result}' and '#{raw_result_adjacent}'"
      else
        result = raw_result
        @info_add = ", not interpolated for adjacent is '#{raw_result_adjacent}' of '#{raw_result}'"
      end
      result
    end

    def make_stats
      club_stat = ClubStat.new(self)
      stat_names.map { |stat_name| [stat_name, club_stat.send(stat_name)] }.to_h
    end

    def stat_names
      case name
      when 'drive'
        %i[drive_distance fairway_keeping]
      when 'putt'
        %i[putting_distance]
      else
        %i[green_hitting green_hitting_distance]
      end
    end
end
