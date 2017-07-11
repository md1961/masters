class PlayerClubStatSuite

  def find_by_player(player)
    @stats.find { |stat| stat.player == player }
  end

  def initialize(players)
    @stats = players.map { |player| PlayerClubStat.new(player) }
    set_ranks_for_all_categories
  end

  def each
    @stats.each { |stat| yield stat }
  end

  private

    def set_ranks_for_all_categories
      %i[
        drive_distance fairway_keeping
        putting_distance putting_in_from_20 putting_in_from_10 putting_in_from_5
      ].each do |category|
        set_ranks_for(category)
      end
      %i[green_hitting].product(%i[fw li mi si p ch]).each do |category, club_name|
        set_ranks_for(category, club_name)
      end
      %i[green_hitting_distance].product(%i[fw li mi si p ch]).each do |category, club_name|
        set_ranks_for(category, club_name, :asc)
      end
    end

    def set_ranks_for(category, club_name = nil, ordering = :desc)
      values = if club_name
        @stats.map { |stat| stat.send(category, club_name.to_s) }
      else
        @stats.map(&:"#{category}")
      end
      @stats.zip(values) do |stat, value|
        rank = values.count { |v| ordering == :desc ? v > value : v < value } + 1
        stat.set_rank(category, club_name, rank)
      end
    end
end
