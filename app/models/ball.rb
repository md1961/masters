class Ball < ActiveRecord::Base
  belongs_to :player
  belongs_to :shot
end
