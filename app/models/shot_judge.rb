class ShotJudge < ActiveRecord::Base
  belongs_to :shot

  # FIXME: Handle optional results
  def next_club
    next_use
  end
end
