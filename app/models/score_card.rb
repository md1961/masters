class ScoreCard < ActiveRecord::Base
  belongs_to :player
  belongs_to :round
  has_many :scores
end
