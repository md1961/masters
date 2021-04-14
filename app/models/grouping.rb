class Grouping < ApplicationRecord
  belongs_to :group , optional: true
  belongs_to :player, optional: true
end
