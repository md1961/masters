module ScoreCardsHelper

  def class_score_result(stroke, hole)
    return '' unless stroke && hole
    diff = [stroke - hole.par, +3].min
    Ball.result_name(diff).gsub('-', '_').downcase
  end

  def cum_score_display(number, scores, score_at_start)
    score = scores[number - 1]
    return '&nbsp'.html_safe unless score
    value = score.value
    total_value = scores[0, number].map { |s| s&.value || 0 }.sum
    par = score.hole.par
    total_par = Hole.where('number <= ?', score.hole.number).sum(:par)
    total_score = total_value - total_par + score_at_start
    value && value == par ? '&nbsp'.html_safe : score_formatted(total_score, short: true)
  end

  def full_name_with_score(player)
    safe_join([player.first_name,
              with_score(player, score_wrapper: nil, delimiter: ('&nbsp;' * 8).html_safe)],
              '&nbsp;'.html_safe)
  end
end
