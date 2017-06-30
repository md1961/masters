class PlayerClubStatsController < ApplicationController

  def index
    @player_club_stats = Player.all.map { |player| PlayerClubStat.new(player) }
  end
end
