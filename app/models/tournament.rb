class Tournament < ActiveRecord::Base
  include Comparable

  has_many :rounds
  has_many :invitations
  has_many :players, through: :invitations

  def current_round
    rounds.find_by(is_current: true)
  end

  def players_to_play
    players.joins(:invitations).where(invitations: {cut_after_round_number_of: [nil]})
  end

  def leaders
    players = players_to_play
    min_score = players.map(&:tournament_score).min
    players.find_all { |player| player.tournament_score == min_score }
  end

  def new_round!
    current_round_number = current_round&.number
    current_round&.update!(is_current: false)
    new_round_number = current_round_number.to_i + 1
    rounds.create!(number: new_round_number, is_current: true)
  end

  def cut_off!(player)
    invitation = invitations.find_by(player: player)
    invitation.update!(cut_after_round_number_of: current_round.number)
  end

  def finish
    raise "End of Tournament (not implemented yet)"
  end

  def <=>(other)
    return nil if other.nil? || !other.is_a?(Tournament)
    created_at <=> other.created_at
  end
end
