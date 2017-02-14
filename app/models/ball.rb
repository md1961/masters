class Ball < ActiveRecord::Base
  include Comparable

  belongs_to :player
  belongs_to :shot

  attr_reader :info

  after_create :set_next_use_if_nil

  def hole
    shot.try(:hole)
  end

  def holed_out?
    result == 'IN' || result == 'OK'
  end

  def on_green?
    result.to_i > 0 || holed_out?
  end

  def ok?
    result == 'OK'
  end

  def second_putt?
    result =~ /\A\d{1,2}s\z/
  end

  def third_putt?
    result =~ /\A1t\z/
  end

  def superlative?
    result =~ /\*\z/
  end

  def next_use_optional?
    next_use =~ / or /
  end

  def next_use_options
    next_use.split(' or ')
  end

  def accept(club_result)
    @info = ''
    self.next_adjust = 0
    if !shot.is_layup && (%w(IN OK).include?(club_result) || club_result.to_i > 0)
      self.result      = club_result
      self.lands       = 'Green'
      self.next_use    = 'Putt'
      self.shot_count += 1 if club_result == 'OK'
    else
      shot_judge = shot.judge(club_result)
      result_prefix = is_layup && club_result.to_i > 0 ? 'layup-' : ''
      self.result      = result_prefix + club_result
      self.lands       = shot_judge.lands
      self.next_use    = shot_judge.next_use
      self.next_adjust = shot_judge.next_adjust
      decide_optional_lands
      parse_next_use
      self.shot_count += 1 if lands == 'Water'
    end
    player.info += (player.info.blank? ? '' : '; ') + @info if @info.present?
  end

  def choose_next_use(index)
    return unless next_use_optional?
    self.next_use = next_use.split(' or ')[index]
    parse_next_use
  end

  def <=>(other)
    if self.shot != other.shot
      self.shot <=> other.shot
    elsif self.result.nil? && other.result.nil?
      self.player.grouping.play_order <=> other.player.grouping.play_order
    elsif self.result.nil?
      -1
    elsif other.result.nil?
      1
    else
      distance_factor(self.result) <=> distance_factor(other.result)
    end
  end

  def result_display
    if shot_count == 0
      ''
    elsif ok?
      "putt to OK distance to hole out on #{shot_count}"
    elsif holed_out?
      "sink to hole out on #{shot_count}"
    else
      "hit #{shot_count.ordinalize} shot onto #{lands} by '#{result}'"
    end
  end

  def next_shot_display
    "Next: #{shot} '#{next_use}'(#{next_adjust > 0 ? '+' : ''}#{next_adjust}), layup=#{is_layup}"
  end

  private

    RE_STRINGIFIED_HASH = /\A{.*}\z/

    def decide_optional_lands
      return unless lands =~ RE_STRINGIFIED_HASH
      dice = Dice.roll
      lands_orig = lands
      self.lands = look_up_optional_result(eval(lands), dice)
      @info = "'#{lands}' on dice '#{dice}' from #{lands_orig}"
      return unless next_use =~ RE_STRINGIFIED_HASH
      decide_optional_next_use(dice)
    end

    def decide_optional_next_use(dice = nil)
      dice = Dice.roll unless dice
      next_use_orig = next_use
      self.next_use = look_up_optional_result(eval(next_use), dice)
      @info += (@info.present? ? ', ' : '') + "'#{next_use}' on dice '#{dice}' from #{next_use_orig}"
    end

    def look_up_optional_result(hash, num)
      hash.find { |k, _v| num.between?(*(k.split('-').map(&:to_i))) }[1]
    end

    def parse_next_use
      self.is_layup = false
      self.is_saved = false
      if next_use =~ RE_STRINGIFIED_HASH
        decide_optional_next_use
      end
      if next_use =~ /\ASave, (\w.*)\z/
        self.next_use = Regexp.last_match(1)
        self.shot_count += 1
        self.is_saved = true
      end
      if next_use.sub!(/ \(([+-]?\d{1,2})\)\z/, '')
        self.next_adjust += Regexp.last_match(1).to_i
      end
      if next_use =~ /\A([A-Z]{2}) Layup\z/
        self.next_use = Regexp.last_match(1)
        self.is_layup = true
      end
    end

    # FIXME: Implement round-wise choice for tee shot on No.12

    def set_next_use_if_nil
      shot_judges = shot.shot_judges
      self.next_use = shot_judges.first.next_use if next_use.nil? && shot_judges.size == 1
      save!

      @info = ''
      decide_optional_next_use if next_use =~ RE_STRINGIFIED_HASH
    end

    def distance_factor(result)
      if result.to_i > 0
        1000 - result.to_i
      else
        raise "Cannot find key of '#{result}' in H_DISTANCE_FACTOR" unless H_DISTANCE_FACTOR.key?(result)
        H_DISTANCE_FACTOR[result]
      end
    end

    H_DISTANCE_FACTOR = {
      "IN"    => 100000,
      "OK"    => 10000,
      "Sd"    => -10,
      "LC-Ch" => -100,
      "LL-Ch" => -200,
      "LR-Ch" => -300,
      "ML-Ch" => -400,
      "MR-Ch" => -500,
      "SC-Ch" => -600,
      "SL-Ch" => -700,
      "SR-Ch" => -800,
      "SC-P"  => -1000,
      "SL-P"  => -2000,
      "SR-P"  => -3000,
      "LC*"   => -10100,
      "LC"    => -10200,
      "LL"    => -10300,
      "LR"    => -10400,
      "MC*"   => -10500,
      "MC"    => -10600,
      "ML"    => -10700,
      "MR"    => -10800,
      "SC*"   => -10900,
      "SC"    => -11000,
      "SL"    => -11100,
      "SR"    => -11200,
    }
end
