class Shot < ActiveRecord::Base
  belongs_to :hole
  has_many :shot_judges
  has_many :balls
  has_many :players, through: :balls
end
