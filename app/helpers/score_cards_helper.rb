module ScoreCardsHelper

  def class_score_result(stroke, hole)
    return '' unless stroke && hole
    diff = [stroke - hole.par, +3].min
    Ball.result_name(diff).gsub('-', '_').downcase
  end
end
