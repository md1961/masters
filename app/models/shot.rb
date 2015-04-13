class Shot < ActiveRecord::Base
  has_many :shot_judges
  belongs_to :hole
end
