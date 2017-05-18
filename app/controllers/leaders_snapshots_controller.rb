class LeadersSnapshotsController < ApplicationController

  def index
    tournament = Tournament.find_by(id: params[:tournament_id]) || Tournament.order(:created_at).last
    redirect_to leaders_snapshot_path(tournament.last_leaders_snapshot)
  end

  def show
    @leaders_snapshot = LeadersSnapshot.find(params[:id])
    set_prev_and_next
  end

  private

  # TODO: Move set_prev_and_next() to model LeadersSnapshot.
    def set_prev_and_next
      round = @leaders_snapshot.round
      @prev = LeadersSnapshot.where(round: round).
        where('seq_num < ?', @leaders_snapshot.seq_num).order(seq_num: :desc).limit(1).first \
        || LeadersSnapshot.where(round: round.prev).order(seq_num: :desc).limit(1).first
      @next = LeadersSnapshot.where(round: round).
        where('seq_num > ?', @leaders_snapshot.seq_num).order(:seq_num).limit(1).first \
        || LeadersSnapshot.where(round: round.next).order(:seq_num).limit(1).first
    end
end
