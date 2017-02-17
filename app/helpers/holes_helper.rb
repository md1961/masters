module HolesHelper

  LANDING_GRIDS = [%w(SL ML LL), %w(SC MC LC), %w(SR MR LR)]

  def fairway_landings(hole)
    return [] if hole.par <= 3
    LANDING_GRIDS.map do |row|
      row.map do |result|
        hole.shots.find_by(number: 2).judge(result)
      end
    end
  end

  def green_landings(hole)
    shot_number = hole.par - 1
    LANDING_GRIDS.map do |row|
      row.map do |result|
        result += '-Ch'
        result == 'MC-Ch' ? 'GREEN' : hole.shots.find_by(number: shot_number).judge(result)
      end
    end
  end
end
