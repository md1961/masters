class OldClub < ApplicationRecord
  belongs_to :player, optional: true
  has_many :old_club_results
end
