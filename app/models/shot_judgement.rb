class ShotJudgement
  attr_accessor :club_name, :is_layup, :dice_adjust, :shot_count_addend

  def initialize
    @is_layup = false
    @dice_adjust = 0
    @shot_count_addend = 0
  end
end
