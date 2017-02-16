class Tournament < ActiveRecord::Base
  has_many :rounds
  has_many :invitations
  has_many :players, through: :invitations

  def current_round
    rounds.find_by(is_current: true)
  end

  def new_round!
    round = current_round
    round&.update!(is_current: false)
    new_round_number = (round&.number || 0) + 1
    rounds.create!(number: new_round_number, is_current: true)
  end

  def finish
    raise "End of Tournament (not implemented yet)"
  end
end
