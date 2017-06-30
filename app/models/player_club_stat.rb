class PlayerClubStat
  attr_reader :player

  def initialize(player)
    @player = player
    @h_club_stats = player.clubs.map { |club| [club.name, ClubStat.new(club)] }.to_h
  end

  def drive_distance
    @h_club_stats['drive'].drive_distance
  end

  def fairway_keeping
    @h_club_stats['drive'].fairway_keeping
  end

  def drive_pulling
  end
  def drive_pushing
  end
  def super_driving
  end

  def green_hitting(club_name)
    @h_club_stats[club_name].green_hitting || "N/A(#{club_name})"
  end

  def green_hitting_distance(club_name)
    @h_club_stats[club_name].green_hitting_distance || "N/A(#{club_name})"
  end

  def putting_in_from(distance)
  end
  def erratic_putting
  end
end
