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
  def green_hitting
  end
  def green_hitting_distance
  end
  def putting_in_from(distance)
  end
  def erratic_putting
  end
end
