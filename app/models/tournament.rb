class Tournament < ActiveRecord::Base
  has_many :rounds
  has_many :invitations
  has_many :players, through: :invitations

  def current_round
    rounds.find_by(is_current: true)
  end

  def new_round!
    current_round_number = current_round&.number
    current_round&.update!(is_current: false)
    new_round_number = current_round_number.to_i + 1
    rounds.create!(number: new_round_number, is_current: true)
  end

  def finish
    raise "End of Tournament (not implemented yet)"
  end
end
