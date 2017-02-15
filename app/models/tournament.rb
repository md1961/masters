class Tournament < ActiveRecord::Base
  has_many :rounds

  def current_round
    rounds.find_by(is_current: true)
  end

  def finish
    raise "End of Tournament (not implemented yet)"
  end
end
