class PlayerClubStatSuite

  def initialize(players)
    @stats = players.map { |player| PlayerClubStat.new(player) }
    set_ranks_for_all_categories
  end

  def each
    @stats.each { |stat| yield stat }
  end

  private

    def set_ranks_for_all_categories
      %i[drive_distance fairway_keeping].each do |category|
        set_ranks_for(category)
      end
      %i[green_hitting].product(%i[fw li mi si]).each do |category, club_name|
        set_ranks_for(category, club_name)
      end
    end

    def set_ranks_for(category, club_name = nil)
      values = if club_name
        @stats.map { |stat| stat.send(category, club_name.to_s) }
      else
        @stats.map(&:"#{category}")
      end
      @stats.zip(values) do |stat, value|
        rank = values.count { |v| v > value } + 1
        stat.set_rank(category, club_name, rank)
      end
    end
end
