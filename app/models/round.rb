class Round < ActiveRecord::Base
  belongs_to :tournament
  has_many :areas , -> { order(:seq_num) }
  has_many :groups, -> { order(:number ) }
  has_many :score_cards

  enum status: {displays_result: 0, ready_to_play: 1, changing_group: 2, needs_input: 3, finished: 99}

  attr_reader :message

  # TODO: Add attribute current_player, or else

  # TODO: Add attribute first_hole_number, or else
  def first_hole_number
    1
  end
  def final_hole_number
    first_hole_number == 1 ? 18 : first_hole_number - 1
  end

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

  def group_to_display
    changing_group? ? current_group.prev_playing : current_group
  end

  def first_group_playing
    groups.detect(&:playing?)
  end

  def club_name_used
    play_result =~ Group::RE_PLAYER_ID_AND_INFO && Regexp.last_match(2)
  end

  # TODO: Refactor proceed() by splitting or else.
  def proceed(shot_option: nil)
    if (needs_input? && shot_option.present?)
      self.status = :ready_to_play
    elsif changing_group?
      self.status = :displays_result
    end
    will_toggle_status = true
    @message = nil
    if ready_to_play?
      if current_group.needs_to_choose_shot? && shot_option.nil?
        needs_input!
        return
      end
      group_to_play = current_group
      # TODO: Quit receiving messy string result from Group#play().
      player_id_and_info = group_to_play.play(index_option: shot_option && Integer(shot_option))
      if player_id_and_info.nil?
        will_toggle_status = false
      elsif groups.none?(&:players_split?) && group_to_play.play_finished
        changing_group!
        will_toggle_status = false
      end
      update!(play_result: player_id_and_info)
      @message = group_to_play&.message
      if areas.first.open? && areas.second.open? && groups.any?(&:not_started_yet?)
        group = groups.detect(&:not_started_yet?)
        group.tee_up_on(first_hole_number)
      end
    end
    if groups.all?(&:round_finished?)
      finished!
      update!(play_result: "#{self} finished")
    elsif will_toggle_status
      ready_to_play? ? displays_result! : ready_to_play!
    end
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
      Area.all.each { |area| area.update!(round: self) } if number >= 2

      tee_shot_on_hole_12 = Shot.find_by(hole: Hole.find_by(number: 12), number: 1)
      h_option_tee_shot_12 = eval(tee_shot_on_hole_12.shot_judges.first.next_use)
      dice = Dice.roll
      update!(club_name_for_12_tee: Ball.look_up_optional_result(h_option_tee_shot_12, dice))

      if number == 1
        players_sorted = tournament.players_to_play.map { |p| [p, rand] }.sort_by(&:last).map(&:first)
      else
        # TODO: Add sort item in case tournament_stroke is equal (Not tested yet).
        round_prev = Round.find_by(number: number - 1)
        players_sorted = tournament.players_to_play.sort_by { |player|
          strokes_last_first = player.score_cards.find_by(round: round_prev).scores.pluck(:value).reverse
          [player.tournament_stroke, strokes_last_first]
        }.reverse
      end
      # TODO: Can destroy old Grouping's ?
      Grouping.destroy_all
      group_number = 1
      players_sorted.each_slice(Round.num_players_per_group) do |players|
        group = groups.create!(number: group_number, players: players)
        group.groupings.find_by(player: players[0]).update!(play_order: 2)
        group.groupings.find_by(player: players[1]).update!(play_order: 1)
        group_number += 1
      end
      players_sorted.each { |player| player.ball&.destroy }

      raise "All Area should be open" unless areas.all?(&:open?)

      group1 = groups.find_by(number: 1)
      group1.tee_up_on(first_hole_number)

      groups.flat_map(&:players).each do |player|
        player.score_cards.create!(round: self)
      end
    end

    def create_areas_for_round_one
      Area.create_all_for(self)
    end
end
