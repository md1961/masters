class Score < ApplicationRecord
  belongs_to :score_card
  belongs_to :hole
end
