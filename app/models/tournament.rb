class Tournament < ApplicationRecord
  include Comparable

  has_many :rounds, -> { order(:number) }
  has_many :invitations
  has_many :players, through: :invitations

  def current_round
    rounds.find_by(is_current: true)
  end

  def players_to_play
    invitations.where(cut_after_round_number_of: [nil]).map(&:player)
  end

  def leaders
    players = players_to_play
    min_score = players.map(&:tournament_score).min
    players.find_all { |player| player.tournament_score == min_score }
  end

  def last_leaders_snapshot
    round = current_round
    round = rounds.where(round.number - 1) unless LeadersSnapshot.where(round: round).exists?
    LeadersSnapshot.where(round: round).order(:seq_num).last
  end

  def new_round!
    current_round_number = current_round&.number
    current_round&.update!(is_current: false)
    new_round_number = current_round_number.to_i + 1
    rounds.create!(number: new_round_number, is_current: true)
  end

  def playoff
    current_round.update!(is_current: false)
    Playoff.create!(tournament: self, is_current: true)
  end

  def cut_off!(player)
    invitation = invitations.find_by(player: player)
    invitation.update!(cut_after_round_number_of: current_round.number)
  end

  def <=>(other)
    return nil if other.nil? || !other.is_a?(Tournament)
    created_at <=> other.created_at
  end

  def to_s
    "#{year} #{name}"
  end
end
