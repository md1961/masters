class LeadersSnapshotsController < ApplicationController

  def index
    tournament = Tournament.order(:created_at).last
    round = tournament.current_round
    redirect_to leaders_snapshot_path(LeadersSnapshot.where(round: round).order(:seq_num).first)
  end

  def show
    @leaders_snapshot = LeadersSnapshot.find(params[:id])
    set_prev_and_next
  end

  private

    def set_prev_and_next
      @prev = LeadersSnapshot.where(round: @leaders_snapshot.round).
        where('seq_num < ?', @leaders_snapshot.seq_num).order(seq_num: :desc).limit(1).first
      @next = LeadersSnapshot.where(round: @leaders_snapshot.round).
        where('seq_num > ?', @leaders_snapshot.seq_num).order(:seq_num).limit(1).first
    end
end
