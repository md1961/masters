class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas , -> { order(:seq_num) }
  has_many :groups, -> { order(:number ) }
  has_many :score_cards

  # FIXME: Add COLUMN club_id_for_12_tee, or else.
  # FIXME: Add COLUMN created_at.

  # FIXME: Add attribute first_hole_number, or else
  def first_hole_number
    1
  end
  def final_hole_number
    first_hole_number == 1 ? 18 : first_hole_number - 1
  end

  enum status: {displays_result: 0, ready_to_play: 1, needs_input: 2, finished: 99}

  attr_reader :message

  after_create :create_areas_for_round_one, if: :first_round?
  after_create :setup_groups_and_score_cards

  def self.num_players_per_group
    2
  end

  def dice_roll_for_club_on_12_tee
    1  # for {'1-3' => 'MI', '4-6' => 'SI'}
  end

  def first_round?
    number == 1
  end

  def final_round?
    number == tournament.num_rounds
  end

  def current_group
    groups.detect(&:players_split?) || groups.reverse.detect(&:next_area_open?)
  end

  # TODO: Refactor proceed() by splitting or else.
  def proceed(shot_option: nil)
    self.status = :ready_to_play if needs_input? && shot_option.present?
    skips_result_display = false
    @message = nil
    if areas.all?(&:open?)
    # TODO: Should move this block to another method.
      group1 = groups.find_by(number: 1)
      group1.tee_up_on(first_hole_number)
    elsif groups.all?(&:round_finished?)
      finished!
      update!(play_result: ["#{self} finished"])
      return
    elsif ready_to_play?
      if current_group.needs_to_choose_shot? && shot_option.nil?
        needs_input!
        return
      end
      # FIXME: Think how to hand result strings to view.
      array_of_play_results = current_group.play(index_option: shot_option && Integer(shot_option))
      skips_result_display = true if array_of_play_results.empty?
      update!(play_result: array_of_play_results)
      @message = current_group.message
      if areas.first.open? && groups.any?(&:not_started_yet?)
        group = groups.detect(&:not_started_yet?)
        group.tee_up_on(first_hole_number)
      end
    end
    ready_to_play? ? displays_result! : ready_to_play! unless skips_result_display
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(Round)
    self.tournament == other.tournament && self.number == other.number
  end

  def to_s
    "Round #{number}"
  end

  private

    def setup_groups_and_score_cards
      if number == 1
        players_shuffled = Player.all.map { |p| [p, rand] }.sort_by(&:last).map(&:first)
      else
        raise 'Not implemented yet for Round 2 or later'
      end

      group_number = 1
      players_shuffled.each_slice(Round.num_players_per_group) do |players|
        group = groups.create!(number: group_number, players: players)
        group.groupings.find_by(player: players[0]).update!(play_order: 1)
        group.groupings.find_by(player: players[1]).update!(play_order: 2)
        group_number += 1
      end

      groups.flat_map(&:players).each do |player|
        player.score_cards.create!(round: self)
      end
    end

    def create_areas_for_round_one
      Area.create_all_for(self)
    end
end
