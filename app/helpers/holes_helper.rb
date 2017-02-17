module HolesHelper

  def fairway_landings(hole)
    return [] if hole.par <= 3
    [%w(SL ML LL), %w(SC MC LC), %w(SR MR LR)].map do |row|
      row.map do |prev_result|
        hole.shots.find_by(number: 2).shot_judges.find_by(prev_result: prev_result)
      end
    end
  end
end
