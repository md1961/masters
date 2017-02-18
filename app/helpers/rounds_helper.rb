module RoundsHelper

  def score_formatted(value)
    value.zero? ? 'even' : format('%+d', value)
  end

  def area_display(player)
    area = player.shot.area
    modifier = area.green? && player.ball.result.to_i == 0 ? 'vicinity' : ''
    "#{area} #{modifier}"
  end

  def target_display(ball)
    if ball.on_green?
      "putting for #{ball.hole_result(1)}"
    else
      ''
    end
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
