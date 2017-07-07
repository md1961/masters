class PlayerClubStat
  attr_reader :player

  def initialize(player)
    @player = player
    @h_club_stats = player.clubs.map { |club| [club.name, ClubStat.new(club)] }.to_h
    @h_ranks = {}
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

  def rank(category, club_name = nil)
    rank = @h_ranks[category.to_sym]
    rank.is_a?(Hash) && club_name ? rank[club_name.to_sym] : rank
  end

  def set_rank(category, club_name, value)
    if club_name
      @h_ranks[category.to_sym] = {} unless @h_ranks[category.to_sym]
      @h_ranks[category.to_sym][club_name.to_sym] = value
    else
      @h_ranks[category.to_sym] = value
    end
  end
end
