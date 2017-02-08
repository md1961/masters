class ShotJudge < ActiveRecord::Base
  belongs_to :shot

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

  def determine
    judgement = ShotJudgement.new
    judgement.dice_adjust = next_adjust
    if next_use =~ /\A([A-Z]{2}) Layup\z/
      judgement.club_name = Regexp.last_match(1)
      judgement.is_layup = true
    elsif next_use =~ /\ASave, ([A-Z]{2})\z/
      judgement.club_name = Regexp.last_match(1)
      judgement.shot_count_addend = 1
    else
      judgement.club_name = next_use
    end
    judgement
  end
end
