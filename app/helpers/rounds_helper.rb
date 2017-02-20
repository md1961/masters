module RoundsHelper

  def num_groups_in_players_info
    5
  end

  def groups_with_to_display_at_top
    @round.groups.rotate(@round.group_to_display.number - 1)
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
    ball.on_green? ? "putting for #{ball.hole_result(1)}" : ''
  end

  def pre_shot_display(player)
    ball = player.ball
    distance = ball.on_green? ? " #{ball.result}" : ''
    "#{player} on #{area_display(player)}#{distance} #{target_display(ball)}"
  end

  def hole_result_display(group)
    group.players.map { |player|
      ball = player.ball
      "#{player} #{ball.shot_count} (#{ball.hole_result})"
    }.join(', ')
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
    value && value == par ? nil : format('%+d', total_value - total_par).sub('+0', ' 0')
  end
end
