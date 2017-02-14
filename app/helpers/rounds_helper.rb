module RoundsHelper

  def total_score_display(player, round)
    score = player.score_cards.find_by(round: round).total_score
    score.zero? ? 'even' : format('%+d', score)
  end
end
