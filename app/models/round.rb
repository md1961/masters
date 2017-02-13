class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas , -> { order(:seq_num) }
  has_many :groups, -> { order(:number ) }

  enum status: {displays_result: 0, ready_to_play: 1, needs_input: 2}

  after_create :setup_group_for_round_one, :create_areas_for_round_one, if: :first_round?

  def self.num_players_per_group
    2
  end

  def first_round?
    number == 1
  end

  def first_hole_number
    1
  end

  def current_group
    groups.detect(&:players_split?) || groups.reverse.detect(&:next_area_open?)
  end

  def proceed
    # TODO: Should move this block to another method.
    if areas.all?(&:open?)
      group1 = groups.find_by(number: 1)
      group1.tee_up_on(first_hole_number)
    elsif ready_to_play?
      if current_group.needs_to_choose_shot?
        needs_input?
      else
        array_of_play_results = current_group.play
        # FIXME: Think how to hand result strings to view.
        update!(play_result: array_of_play_results)
        if areas.first.open? && groups.any?(&:not_started_yet?)
          group = groups.detect(&:not_started_yet?)
          group.tee_up_on(first_hole_number)
        end
      end
    end
    ready_to_play? ? displays_result! : ready_to_play!
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(Round)
    self.tournament == other.tournament && self.number == other.number
  end

  def to_s
    "Round #{number}"
  end

  private

    def setup_group_for_round_one
      players_shuffled = Player.all.map { |p| [p, rand] }.sort_by(&:last).map(&:first)
      number = 1
      players_shuffled.each_slice(Round.num_players_per_group) do |players|
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
