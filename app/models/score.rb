class Score < ActiveRecord::Base
  belongs_to :score_card
  belongs_to :hole
end
