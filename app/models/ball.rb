class Ball < ActiveRecord::Base
  belongs_to :player
  belongs_to :shot

  after_create :set_next_use_if_nil

  def set_next_use_if_nil
    shot_judges = shot.shot_judges
    self.next_use = shot_judges.first.next_use if next_use.nil? && shot_judges.size == 1
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

  # TODO: Handle layup results.
  def accept(result)
    self.next_adjust = 0
    self.is_layup = false
    if result == 'OK'
      self.result      = 'IN'
      self.lands       = 'Green'
      self.next_use    = 'Putt'
    elsif !shot.is_layup && (result == 'IN' || result.to_i > 0)
      self.result      = result
      self.lands       = 'Green'
      self.next_use    = 'Putt'
    else
      shot_judge = shot.judge(result)
      self.result      = shot_judge.prev_result
      self.lands       = shot_judge.lands
      self.next_use    = shot_judge.next_use
      self.next_adjust = shot_judge.next_adjust
      parse_next_use
    end
  end

  private

    # FIXME: Handle optional results
    # [ 0] "FW Layup",
    # [ 1] "LI Layup",
    # [ 2] "MI Layup",
    # [ 3] "SI Layup",
    # [ 4] "SI Layup (+1) or LI",
    # [ 5] "SI Layup (+1) or LI (-2)",
    # [ 6] "SI Layup or FW",
    # [ 7] "SI Layup or FW (-1)",
    # [ 8] "SI Layup or LI (-2)",
    # [ 9] "Save",
    # [10] "Save, FW",
    # [11] "Save, LI",
    # [12] "{'1-2' => 'P', '3-6' => 'Ch'}",
    # [13] "{'1-2' => 'Save, SI', '3-4' => 'Sand, P', '5-6' => 'LI'}",
    # [14] "{'1-3' => 'MI', '4-6': SI'}",
    # [15] "{'1-3' => 'P', '4-6' => 'Ch'}",
    # [16] "{'1-3' => 'SI', '4-6' => 'Ch'}",
    # [17] "{'1-3' => 'Save, LI Layup', '4-6' => 'Save, FW'}",
    # [18] "{'1-3' => 'Save, LI', '4-5' => 'Save, MI', '6' -> 'Save, SI'}",
    # [19] "{'1-3' => 'Save, LI', '4-6' => 'Save, LI Layup'}"

    def parse_next_use
      if next_use =~ /\A([A-Z]{2}) Layup\z/
        self.next_use = Regexp.last_match(1)
        self.is_layup = true
      elsif next_use =~ /\ASave, ([A-Z]{2})\z/
        self.next_use = Regexp.last_match(1)
        self.shot_count += 1
      end
    end
end
