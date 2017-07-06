class PlayerClubStatSuite

  def initialize(players)
    @stats = players.map { |player| PlayerClubStat.new(player) }
  end

  def each
    @stats.each { |stat| yield stat }
  end
end
