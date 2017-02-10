class Group < ActiveRecord::Base
  belongs_to :round
  belongs_to :area
  has_many :groupings
  has_many :players, through: :groupings
end
