class PlayerClubsController < ApplicationController

  # "command"=>"copy_left_to_right", "club_name"=>"FW", "player_left_id"=>"15", "player_right_id"=>"1"
  def alter
    club_name = params[:club_name]
    player_left  = Player.find(params[:player_left_id])
    player_right = Player.find(params[:player_right_id])
    begin
      ActiveRecord::Base.transaction do
        case params[:command]
        when 'copy_left_to_right'
          player_right.receive_club(club_name, player_left)
        when 'copy_right_to_left'
          player_left.receive_club(club_name, player_right)
        when 'swap'
          #"Swap #{player_left}'s #{club_name} to #{player_right}'s #{club_name}"
        else
          raise "ILLEGAL COMMAND '#{params[:command]}'"
        end
      end
    rescue => e
      raise e
    end
    redirect_to player_club_stat_suites_path
  end

  def restore
    player = Player.find(params[:player_id])
    club_name = params[:club_name]
    begin
      ActiveRecord::Base.transaction do
        player.restore_old_club(club_name)
      end
    rescue => e
      raise e
    end
    redirect_to player_club_stat_suites_path
  end
end
