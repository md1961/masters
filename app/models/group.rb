class Group < ApplicationRecord
  belongs_to :round
  has_many :groupings, -> { order(:play_order) }
  has_many :players, through: :groupings

  # TODO: Consider to convert attr_reader :play_finished to method.

  attr_reader :play_finished, :message

  def final_group?
    self == round.groups.last
  end

  def players_gone_to_next_area?
    players.none? { |player| player.shot.area == area }
  end

  def players_area_uniq
    players.map(&:ball).compact.map(&:shot).compact.map(&:area).compact.uniq
  end

  def not_started_yet?
    players.first.ball.nil?
  end

  def players_split?
    players_area_uniq.size > 1
  end

  def next_area_open?
    return false if round_finished?
    return false if players_split?
    area = players_area_uniq.first
    area && (area.final? || area.next.try(:open?))
  end

  def all_on_or_near_green?
    players.all? { |player| player.shot.area.green? }
  end

  def all_holed_out?
    players.all? { |player| player.ball&.holed_out? }
  end

  def needs_to_choose_shot?
    next_player.ball.next_use_optional?
  end

  def round_finished?
    players.all? { |player| player.finished_round? }
  end

  def playing?
    !not_started_yet? && !round_finished?
  end

  def shooting_into_final_area?
    areas = players_area_uniq
    areas.size == 1 && areas.first == round.areas[-2]
  end

  def prev
    groups = round.groups
    index = groups.index(self)
    groups[index - 1]
  end

  def prev_playing
    groups_playing = round.groups.find_all(&:playing?)
    index = groups_playing.index(self)
    groups_playing[index - 1]
  end

  def prev_just_played
    shooting_into_final_area? ? prev : prev_playing
  end

  def tee_up_on(hole_number)
    shot = Shot.first_tee(hole_number)
    players.each { |player| player.create_ball!(shot: shot) }
  end

  def next_player
    players.reject { |p| p.ball.nil? }.sort_by { |p| [p.ball, p.play_order] }.first
  end

  def play(index_option: nil)
    @play_finished = !all_on_or_near_green?
    @message = nil
    if all_holed_out?
      return nil unless next_area_open?
      if round.playoff?
        min_stroke = players.map(&:ball).map(&:shot_count).min
        players.each do |player|
          player.grouping.destroy if player.ball.shot_count > min_stroke
        end
        reload
      end
      update_play_order
      hole_number = players.first.shot.hole.number
      next_hole_number = round.next_hole_number(hole_number)
      if next_hole_number.nil?
        finish_round
      else
        tee_up_on(next_hole_number)
      end
      nil
    else
      player = next_player
      ball = player.ball
      has_putted = ball.on_green?
      was_layup = ball.is_layup || index_option&.zero?
      distance = ball.result.to_i
      location = distance > 0 ? distance.to_s : ball.lands
      location = 'Tee' if location.blank?
      location += ' Fringe' if location == 'Water'
      info = player.play(index_option: index_option)
      lands = ball.lands
      if ball.result =~ /\A([SML][LRC].*)\z/
        lands += '-' + Regexp.last_match(1)
      end
      @message = ball.direct_in? ? 'IN!' : has_putted ? 'miss!' : ''
      @message += " from #{location} to #{ball.on_green? ? ball.result : lands}" unless was_layup
      # FIXME: Eliminate ridiculous return value from play().
      "player_id=#{player.id}&club_used=#{ball.club_used}&#{info}"
    end
  end

  RE_PLAYER_ID_AND_INFO = /\Aplayer_id=(\d+)&club_used=(\w+)&(.*)\z/
  RE_ADDITIONAL_MESSAGE = / from (\S.*) to (\S.*)\z/

  def ==(other)
    return false if other.nil? || !other.is_a?(Group)
    self.round == other.round && self.number == other.number
  end

  def eql?(other)
    self == other
  end

  def hash
    [round.hash, number.hash]
  end

  def to_s
    "Group ##{number}"
  end

  private

    def update_play_order
      players.sort_by { |p| [p.ball.shot_count, p.grouping.play_order] }.
        inject(1) { |order, player| player.grouping.update!(play_order: order); order + 1 }
    end

    def finish_round
      players.each { |player| player.ball.finish_round! }
    end
end
