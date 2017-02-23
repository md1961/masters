module HolesHelper

  LANDING_GRIDS = [%w(SL ML LL), %w(SC MC LC), %w(SR MR LR)]

    # TODO: Move players_in_landings() to Round ?
    def players_in_landings(result)
      @round.group_to_display.players.find_all do |player|
        player_result = player.ball.result
        if result == 'MC-Ch'
          player_result.to_i > 0
        else
          player_result&.sub(/\*\z/, '')&.sub(/\A(layup)-\d+\z/, '\1') == result
        end
      end
    end

  def fairway_landings(hole)
    return [[content_tag(:td, nil)] * 3] * 3 if hole.par <= 3
    LANDING_GRIDS.map do |row|
      row.map do |result|
        shot_judge = hole.shots.find_by(number: 2).judge(result)
        players = players_in_landings(result)
        clazz = shot_judge.lands.gsub(' ', '').underscore
        clazz += ' players' unless players.empty?
        content_tag :td, hole_map_element(shot_judge, players), class: clazz
      end
    end
  end

  def green_landings(hole)
    shot_number = hole.par == 3 ? 2 : 3
    LANDING_GRIDS.map { |row| [row.first] + row }.map do |row|
      row.map.with_index do |result, i|
        result += i == 0 ? '-P' : '-Ch'
        is_green = result == 'MC-Ch'
        shot_judge = hole.shots.find_by(number: shot_number, is_layup: false).judge(result)
        lands = shot_judge.lands
        lands = eval(lands).values.join(' ') if lands.start_with?('{')
        players = players_in_landings(result)
        clazz = is_green ? 'green' : lands.gsub(' ', '').underscore
        clazz += ' players' unless players.empty?
        content_tag :td, hole_map_element(is_green ? 'P' : shot_judge, players), class: clazz
      end
    end
  end

  def hole_map_element(shot_judge, players)
    players = players.empty? ? '&nbsp'.html_safe : players.join(',')
    safe_join([shot_judge, players], '<br>'.html_safe)
  end
end
