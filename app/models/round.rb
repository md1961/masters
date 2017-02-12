class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas , -> { order(:seq_num) }
  has_many :groups, -> { order(:number ) }

  after_create :setup_group_for_round_one, :create_areas_for_round_one, if: :first_round?

  def num_players_per_group
    2
  end

  def first_round?
    number == 1
  end

  # FIXME: Not work on web.

  attr_reader :current_player, :result_display

  def ready_to_play?
    value = @ready_to_play
    @ready_to_play = !@ready_to_play
    value
  end

  # =====

  def current_group
    groups.detect(&:players_split?) || groups.reverse.detect(&:next_area_open?)
  end

  def proceed
    if ready_to_play?

      # TODO: Alternative way?
      groups.flat_map(&:players).map(&:reload)

      @current_player = current_group.next_player
      @result_display = @current_player.play

      # TODO: Alternative way?
      areas.flat_map(&:shots).map(&:reload)

      if areas.first.open? && groups.any?(&:not_started_yet?)
        group = groups.detect(&:not_started_yet?)
        group.tee_up_on(1)
      end
    elsif areas.all?(&:open?)
      group1 = groups.find_by(number: 1)
      group1.tee_up_on(1)
    else
      group = current_group
      # group.set_to_next_area if group.players_gone_to_next_area?
    end
    puts self
  end

  def ==(other)
    self.tournament == other.tournament && self.number == other.number
  end

  def to_s
    if @ready_to_play
      group = current_group
      (["#{group} about to stroke from #{group.next_player.shot.area}"] \
        + group.players.map(&:ball)).
        join("\n")
    else
      result_display
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
