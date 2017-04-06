class LeadersSnapshot < ActiveRecord::Base
  belongs_to :round
  has_many :leaders, dependent: :destroy
end
