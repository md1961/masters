class Club < ActiveRecord::Base
  has_many :club_results
  belongs_to :player

  def to_s
    name
  end
end
