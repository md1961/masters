class PlayerClubsController < ApplicationController

  def alter
    club_name = params[:club_name]
    player_left  = Player.find(params[:player_left_id])
    player_right = Player.find(params[:player_right_id])
    alert = nil
    if player_left.has_same_club?(club_name, player_right)
      alert = 'Clubs are identical'
    else
      begin
        ActiveRecord::Base.transaction do
          case params[:command]
          when 'copy_left_to_right'
            player_right.receive_club(club_name, player_left )
          when 'copy_right_to_left'
            player_left .receive_club(club_name, player_right)
          when 'swap'
            player_left.swap_clubs(club_name, player_right)
          else
            raise "ILLEGAL COMMAND '#{params[:command]}'"
          end
        end
      rescue => e
        raise e
      end
    end
    redirect_to player_club_stat_suites_path, alert: alert
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
