class Hole < ActiveRecord::Base
  include Comparable

  has_many :shots

  def <=>(other)
    self.number <=> other.number
  end

  def full_desc
    "#{self} (Par #{par})"
  end

  def to_s
    "No.#{number}"
  end
end
