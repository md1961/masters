module HolesHelper

  LANDING_GRIDS = [%w(SL ML LL), %w(SC MC LC), %w(SR MR LR)]

  def fairway_landings(hole)
    return [] if hole.par <= 3
    LANDING_GRIDS.map do |row|
      row.map do |result|
        shot_judge = hole.shots.find_by(number: 2).judge(result)
        clazz = shot_judge.lands.gsub(' ', '').underscore
        content_tag :td, shot_judge, class: clazz
      end
    end
  end

  def green_landings(hole)
    shot_number = hole.par - 1
    LANDING_GRIDS.map do |row|
      row.map do |result|
        result += '-Ch'
        shot_judge = hole.shots.find_by(number: shot_number).judge(result)
        is_green = result == 'MC-Ch'
        clazz = is_green ? 'green' : shot_judge.lands.gsub(' ', '').underscore
        content_tag :td, is_green ? 'P' : shot_judge, class: clazz
      end
    end
  end
end
