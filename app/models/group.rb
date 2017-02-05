class Group < ActiveRecord::Base
  belongs_to :round
  belongs_to :playing_at
end
