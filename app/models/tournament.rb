class Tournament < ActiveRecord::Base
  has_many :rounds
  has_many :invitations
  has_many :players, through: :invitations

  def current_round
    rounds.find_by(is_current: true)
  end

  def finish
    raise "End of Tournament (not implemented yet)"
  end
end
