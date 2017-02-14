module RoundsHelper

  def total_score_display(player, round)
    score = player.score_cards.find_by(round: round).total_score
    score.zero? ? 'even' : format('%+d', score)
  end

  def area_display(player)
    area = player.shot.area
    preposition = area.green? && player.ball.result.to_i == 0 ? 'near' : ''
    "#{preposition} #{area}"
  end
end
