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
    number_to_display = @round.group_to_display.number
    n_scroll_out = number_to_display \
                    - (num_groups_in_players_info - offset_from_bottom_of_to_display_in_players_info)
    if n_scroll_out <= 0
      groups
    else
      groups.rotate(n_scroll_out)
    end
  end

  def score_formatted(value)
    value.zero? ? 'Even' : format('%+d', value)
  end

  def area_display(player)
    area = player.shot.area
    modifier = \
      if player.ball.superlative?
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
    "#{player} on #{area_display(player)}#{distance} #{target_display(ball)}"
  end

  def round_result_display(group)
    group.players.map { |player|
      score_card = player.score_cards.find_by(round: @round)
      "#{player} #{score_card.total_value} (#{score_formatted(score_card.total_score)})"
    }.join(', ')
  end

  def cum_score_display(number, scores)
    score = scores[number - 1]
    return nil unless score
    value = score.value
    total_value = scores[0, number].map { |s| s.try(:value) || 0 }.sum
    par = score.hole.par
    total_par = Hole.where('number <= ?', score.hole.number).sum(:par)
    value && value == par ? nil : format('%+d', total_value - total_par).sub('+0', 'E')
  end
end
