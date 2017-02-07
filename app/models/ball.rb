class Ball < ActiveRecord::Base
  belongs_to :player
  belongs_to :shot

  def holed_out?
    result == 'IN'
  end
end
