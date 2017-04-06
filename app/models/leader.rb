class Leader < ActiveRecord::Base
  belongs_to :leaders_snapshot
  belongs_to :player
  belongs_to :hole
end
