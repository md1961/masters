class ShotJudge < ActiveRecord::Base

  # FIXME: Handle optional results
  def next_club
    next_use
  end
end
