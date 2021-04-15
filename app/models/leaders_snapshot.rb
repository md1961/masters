class LeadersSnapshot < ApplicationRecord
  belongs_to :round, optional: true
  has_many :leaders, dependent: :destroy
end
