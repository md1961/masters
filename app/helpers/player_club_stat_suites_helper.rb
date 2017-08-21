module PlayerClubStatSuitesHelper

  def old_club_denote(player, club_name)
    player.has_old_club?(club_name) ? 'D' : '&nbsp;'.html_safe
  end
end
