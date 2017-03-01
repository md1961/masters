module ScoreCardsHelper

  def class_score_result(stroke, hole)
    return '' unless stroke && hole
    diff = [stroke - hole.par, +3].min
    Ball.result_name(diff).gsub('-', '_').downcase
  end

  def cum_score_display(number, scores, score_at_start)
    score = scores[number - 1]
    return nil unless score
    value = score.value
    total_value = scores[0, number].map { |s| s.try(:value) || 0 }.sum
    par = score.hole.par
    total_par = Hole.where('number <= ?', score.hole.number).sum(:par)
    total_score = total_value - total_par + score_at_start
    value && value == par ? '&nbsp'.html_safe : score_formatted(total_score, short: true)
  end
end
