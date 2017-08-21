class PlayerClubStatSuitesController < ApplicationController

  KEY_FOR_PLAYER_IDS = :player_ids_to_show_club_stats

  def show
    @stat_suite = PlayerClubStatSuite.new(Player.all)
    @player_ids_to_show = session[KEY_FOR_PLAYER_IDS] || []
  end

  def remember_player
    player_ids = session[KEY_FOR_PLAYER_IDS] || []
    player_ids << params[:player_id].to_i
    session[KEY_FOR_PLAYER_IDS] = player_ids
    render nothing: true
  end

  def forget_player
    if player_ids = session[KEY_FOR_PLAYER_IDS]
      player_ids.delete(params[:player_id].to_i)
      session[KEY_FOR_PLAYER_IDS] = player_ids
    end
    render nothing: true
  end
end
