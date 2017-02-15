module RoundsHelper

  def total_score_display(player = nil, round = nil, score: nil)
    score = player.score_cards.find_by(round: round).total_score if player && round
    score.zero? ? 'even' : format('%+d', score)
  end

  def area_display(player)
    area = player.shot.area
    preposition = area.green? && player.ball.result.to_i == 0 ? 'near' : ''
    "#{preposition} #{area}"
  end

  def target_display(ball)
    if ball.on_green?
      "putting for #{ball.hole_result(1)}"
    else
      ''
    end
  end

  def cum_score_display(index, scores)
    score = scores[index]
    return nil unless score
    value = score.value
    total_value = scores[0, index + 1].map { |s| s.try(:value) || 0 }.sum
    par = score.hole.par
    total_par = Hole.where('number <= ?', score.hole.number).sum(:par)
    value && value == par ? nil : total_value - total_par
  end
end
