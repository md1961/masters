class ScoreCard < ActiveRecord::Base
  belongs_to :player
  belongs_to :round
  has_many :scores

  def total_value
    scores.sum(:value)
  end

  def total_score
    total_value - total_par
  end

  def total_par
    Hole.where(id: scores.where('value > 0').pluck(:hole_id)).sum(:par)
  end
end
