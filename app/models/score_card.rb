class ScoreCard < ApplicationRecord
  belongs_to :player, optional: true
  belongs_to :round , optional: true
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

  def total_in
    scores.joins(:hole).where('holes.number <= 9').sum(:value)
  end

  def total_out
    scores.joins(:hole).where('holes.number >= 10').sum(:value)
  end
end
