class Hole < ActiveRecord::Base
  include Comparable

  has_many :shots

  def <=>(other)
    self.number <=> other.number
  end

  def to_s
    "No.#{number}"
  end
end
