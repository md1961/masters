class Leader < ApplicationRecord
  belongs_to :leaders_snapshot, optional: true
  belongs_to :player          , optional: true
  belongs_to :hole            , optional: true

  def tournament_score
    score
  end

  def to_s
    player.to_s
  end
end
