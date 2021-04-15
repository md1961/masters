class Score < ApplicationRecord
  belongs_to :score_card, optional: true
  belongs_to :hole      , optional: true
end
