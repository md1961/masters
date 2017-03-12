module RoundsHelper

  def num_groups_in_players_info
    5
  end

  def offset_from_bottom_of_to_display_in_players_info
    2
  end

  def num_players_in_leader_board
    10
  end

  def groups_for_players_info
    groups = @round.groups
    number_to_display = @round.group_to_display&.number.to_i
    n_scroll_out = number_to_display \
                    - (num_groups_in_players_info - offset_from_bottom_of_to_display_in_players_info)
    if n_scroll_out <= 0
      groups
    else
      groups.rotate(n_scroll_out)
    end
  end

  def score_formatted(value, short: false)
    return '-' unless value
    zero_display = short ? 'E' : 'Even'
    value.zero? ? zero_display : format('%+d', value)
  end

  def with_score(player, score_wrapper: '[ %s ]', delimiter: ' ')
    score_wrapper = '%s' unless score_wrapper
    score = score_formatted(player.tournament_score)
    score_display = format(score_wrapper, score)
    safe_join([player, delimiter, score_display])
  end

  def area_display(player)
    area = player.shot.area
    modifier = \
      if player.ball.superlative? && !@no_info
        'with excellent lie'
      elsif area.green? && player.ball.result.to_i == 0
        'vicinity'
      else
        ''
      end
    "#{area} #{modifier}"
  end

  def target_display(ball)
    if ball.on_green?
      "putting for #{ball.hole_result(1)}"
    elsif ball.going_for_green_in_two?
      'going for Green in Two'
    elsif ball.is_layup
      'for layup'
    else
      ''
    end
  end

  def pre_shot_display(player)
    ball = player.ball
    distance = ball.on_green? ? " #{ball.result}" : ''
    safe_join([
      "#{with_score(player)} on #{area_display(player)}#{distance} #{target_display(ball)}",
      content_tag(:span, ' ==>', class: 'blink')
    ])
  end

  def hole_result_preposition(player)
    case player.ball.shot_count <=> player.shot.hole.par
    when -1
      'up to'
    when 1
      'down to'
    else
      'to keep'
    end
  end

  def round_strokes_display(player)
    score_cards = player.tournament_score_cards(round_number_upto: @round.number)
    score_cards.map(&:total_value).join('-')
  end

  def round_result_display(group)
    group.players.map { |player|
      "#{player} #{round_strokes_display(player)} (#{score_formatted(player.tournament_score)})"
    }.join(', ')
  end
end
