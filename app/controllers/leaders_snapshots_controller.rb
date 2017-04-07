class LeadersSnapshotsController < ApplicationController

  def show
    @leaders_snapshot = LeadersSnapshot.find(params[:id])
  end
end
