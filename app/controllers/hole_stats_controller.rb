class HoleStatsController < ApplicationController

  def index
    tournament = Tournament.find(params[:tournament_id])
    @hole_stats = HoleStat.build_all_from(tournament)
    @score_indexes = (-4 .. 4).to_a
  end
end
