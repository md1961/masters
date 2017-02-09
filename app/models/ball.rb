class Ball < ActiveRecord::Base
  belongs_to :player
  belongs_to :shot

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
    end
  end

  def choose_next_use(index)
    return unless next_use_optional?
    self.next_use = next_use.split(' or ')[index]
    parse_next_use
  end

  def to_s
    #"#{player.last_name} on " \
    "#{hole}: #{shot} : stroke ##{shot_count} : '#{result}' on #{lands} : " \
      "Next: '#{next_use}', layup=#{is_layup}, (#{next_adjust > 0 ? '+' : ''}#{next_adjust})"
  end

  private

  # TODO: Find out what 'lands' on 'Penalty' means.

    RE_STRINGIFIED_HASH = /\A{.*}\z/

    def decide_optional_lands
      return unless lands =~ RE_STRINGIFIED_HASH
      r = rand(1..6)
      self.lands    = eval(lands   ).find { |k, _v| r.between?(*(k.split('-').map(&:to_i))) }.last
      self.shot_count += 1 if %w(Water Penalty).include?(lands)
      return unless next_use =~ RE_STRINGIFIED_HASH
      self.next_use = eval(next_use).find { |k, _v| r.between?(*(k.split('-').map(&:to_i))) }.last
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

    def set_next_use_if_nil
      shot_judges = shot.shot_judges
      self.next_use = shot_judges.first.next_use if next_use.nil? && shot_judges.size == 1
    end
end
