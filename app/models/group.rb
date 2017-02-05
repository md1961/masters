class Group < ActiveRecord::Base
  belongs_to :round
  belongs_to :playing_at
  has_many :groupings
  has_many :players, through: :groupings
end
