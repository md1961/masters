class Ball < ActiveRecord::Base
  include Comparable

  belongs_to :player
  belongs_to :shot

  def <=>(other)
    if self.shot != other.shot
      self.shot <=> other.shot
    else
      other.result.to_i <=> self.result.to_i
    end
  end

  attr_reader :info

  after_create :set_next_use_if_nil

  def hole
    shot.try(:hole)
  end

  def holed_out?
    result == 'IN'
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

  def accept(club_result)
    @info = ''
    self.next_adjust = 0
    if !shot.is_layup && (%w(IN OK).include?(club_result) || club_result.to_i > 0)
      self.result      = club_result
      self.lands       = 'Green'
      self.next_use    = 'Putt'
    else
      shot_judge = shot.judge(club_result)
      self.result      = club_result
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

  def result_display
    "#{player.last_name} on #{hole}(Par #{hole.par}): " \
      + (shot_count == 0 ? '' : "hit #{shot_count.ordinalize} shot onto #{lands} by '#{result}'")
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
      self.lands    = look_up_optional_result(eval(lands   ), dice)
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

    # FIXME: Handle optional next_use
    # [ 0] "FW Layup",
    # [ 1] "LI Layup",
    # [ 2] "MI Layup",
    # [ 3] "SI Layup",
    # [ 4] "SI Layup (+1) or LI",
    # [ 5] "SI Layup (+1) or LI (-2)",
    # [ 6] "SI Layup or FW",
    # [ 7] "SI Layup or FW (-1)",
    # [ 8] "SI Layup or LI (-2)",
    # [ 9] "Save, FW",
    # [10] "Save, LI",
    # [11] "{'1-2' => 'P', '3-6' => 'Ch'}",
    # [12] "{'1-2' => 'Save, SI', '3-4' => 'Sand, P', '5-6' => 'LI'}",
    # [13] "{'1-3' => 'MI', '4-6': SI'}",
    # [14] "{'1-3' => 'P', '4-6' => 'Ch'}",
    # [15] "{'1-3' => 'SI', '4-6' => 'Ch'}",
    # [16] "{'1-3' => 'Save, LI Layup', '4-6' => 'Save, FW'}",
    # [17] "{'1-3' => 'Save, LI', '4-5' => 'Save, MI', '6' -> 'Save, SI'}",
    # [18] "{'1-3' => 'Save, LI', '4-6' => 'Save, LI Layup'}"

    def parse_next_use
      self.is_layup = false
      if next_use =~ RE_STRINGIFIED_HASH
        decide_optional_next_use
      end
      if next_use.sub!(/ \(([+-]?\d{1,2})\)\z/, '')
        self.next_adjust += Regexp.last_match(1).to_i
      end
      if next_use =~ /\A([A-Z]{2}) Layup\z/
        self.next_use = Regexp.last_match(1)
        self.is_layup = true
      elsif next_use =~ /\ASave, ([A-Z]{2})\z/
        self.next_use = Regexp.last_match(1)
        self.shot_count += 1
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
end
