class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas
  has_many :groups

  after_create :setup_group_for_round_one, :create_areas_for_round_one

  NUM_PLAYERS_PER_GROUP = 2

  private

    def setup_group_for_round_one
      players_shuffled = Player.all.map { |p| [p, rand] }.sort_by(&:last).map(&:first)
      number = 1
      players_shuffled.each_slice(NUM_PLAYERS_PER_GROUP) do |players|
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
