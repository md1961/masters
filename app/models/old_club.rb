class OldClub < ActiveRecord::Base
  belongs_to :player
  has_many :old_club_results
end
