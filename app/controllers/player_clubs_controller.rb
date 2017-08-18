class PlayerClubsController < ApplicationController

  # "command"=>"copy_left_to_right", "club_name"=>"FW", "player_left_id"=>"15", "player_right_id"=>"1"
  def alter
    club_name = params[:club_name]
    player_left  = Player.find(params[:player_left_id])
    player_right = Player.find(params[:player_right_id])
    render text: case params[:command]
      when 'copy_left_to_right'
        "Copy #{player_left}'s #{club_name} to #{player_right}"
      when 'copy_right_to_left'
        "Copy #{player_right}'s #{club_name} to #{player_left}"
      when 'swap'
        "Swap #{player_left}'s #{club_name} to #{player_right}'s #{club_name}"
      else
        "ILLEGAL COMMAND '#{params[:command]}'"
      end
  end
end
