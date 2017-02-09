class Hole < ActiveRecord::Base
  has_many :shots

  def to_s
    "No.#{number}"
  end
end
