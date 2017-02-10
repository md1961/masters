class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas
  has_many :groups
end
