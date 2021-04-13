class Leader < ApplicationRecord
  belongs_to :leaders_snapshot
  belongs_to :player
  belongs_to :hole

  def tournament_score
    score
  end

  def to_s
    player.to_s
  end
end
