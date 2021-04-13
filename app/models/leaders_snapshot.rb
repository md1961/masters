class LeadersSnapshot < ApplicationRecord
  belongs_to :round
  has_many :leaders, dependent: :destroy
end
