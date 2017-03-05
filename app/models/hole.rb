class Hole < ActiveRecord::Base
  include Comparable

  has_many :shots

  def self.total_par
    Hole.sum(:par)
  end

  H_MAX_DISTANCE_OF_GREEN = {
     3 => 40,
     4 => 45,
     5 => 45,
     7 => 40,
    12 => 40,
  }

  def max_distance_of_green
    H_MAX_DISTANCE_OF_GREEN[number]&.+ rand(11)
  end

  def <=>(other)
    self.number <=> other.number
  end

  def full_desc(with_distance: false)
    distance_display = with_distance ? ", #{distance} yard" : ''
    "#{self} (Par #{par}#{distance_display})"
  end

  def to_s
    "No.#{number}"
  end
end
