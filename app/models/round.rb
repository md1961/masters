class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas
  has_many :groups

  after_create :setup_group_for_round_one, :create_areas_for_round_one, if: :first_round?

  def num_players_per_group
    2
  end

  def first_round?
    number == 1
  end

  def ready_to_play?
    value = @ready_to_play
    @ready_to_play = !@ready_to_play
    value
  end

  def next_group
    first_empty_area = areas.detect(&:no_group?)
    first_empty_area.prev.try(:group)
  end

  def proceed
    if ready_to_play?
      raise
    elsif areas.all?(&:no_group?)
      group1 = groups.find_by(number: 1)
      group1.tee_up_on(1)
    else
      raise
    end
    puts self
  end

  def to_s
    if @ready_to_play
      group = next_group
      (["#{group} about to stroke on #{group.area}"] \
        + group.players.map(&:ball)).
        join("\n")
    else
      raise
    end
  end

  private

    def setup_group_for_round_one
      players_shuffled = Player.all.map { |p| [p, rand] }.sort_by(&:last).map(&:first)
      number = 1
      players_shuffled.each_slice(num_players_per_group) do |players|
        group = groups.create!(number: number, players: players)
        group.groupings.find_by(player: players[0]).update!(play_order: 1)
        group.groupings.find_by(player: players[1]).update!(play_order: 2)
        number += 1
      end
    end

    def create_areas_for_round_one
      Area.create_all_for(self)
    end
end
