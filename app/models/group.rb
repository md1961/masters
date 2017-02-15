class Group < ActiveRecord::Base
  belongs_to :round
  has_many :groupings, -> { order(:play_order) }
  has_many :players, through: :groupings

  attr_reader :message

  def players_gone_to_next_area?
    players.none? { |player| player.shot.area == area }
  end

  def players_area_uniq
    players.map(&:shot).compact.map(&:area).compact.uniq
  end

  def not_started_yet?
    players.first.ball.nil?
  end

  def players_split?
    players_area_uniq.size > 1
  end

  def next_area_open?
    area = players_area_uniq.first
    !players_split? && area && area.next.open?
  end

  def all_on_or_near_green?
    players.all? { |player| player.shot.area.green? }
  end

  def all_holed_out?
    players.all? { |player| player.ball.holed_out? }
  end

  def needs_to_choose_shot?
    next_player.ball.next_use_optional?
  end

  def tee_up_on(hole_number)
    shot = Shot.first_tee(hole_number)
    players.each { |player| player.create_ball!(shot: shot) }
  end

  def next_player
    players.sort_by { |p| [p.ball, p.play_order] }.first
  end

  def play(index_option: nil)
    @message = nil
    if all_holed_out?
      update_play_order
      hole_number = players.first.shot.hole.number
      # TODO: Modify end of round procedure.
      return :end_of_round if hole_number == 18
      hole_number += 1
      tee_up_on(hole_number)
      []
    else
      player = next_player
      is_putting = true if player.ball.on_green?
      info = player.play(index_option: index_option)
      @message = player.ball.direct_in? ? 'IN!' : is_putting ? 'miss' : nil
      hole = player.shot.hole
      [hole.full_desc, player.ball.result_display, player.ball.next_shot_display, info]
    end
  end

  def ==(other)
    return false if other.nil? || !other.is_a?(Group)
    self.number == other.number
  end

  def to_s
    "Group ##{number} (#{players.map(&:to_s).join(', ')})"
  end

  private

    def update_play_order
      players.sort_by { |p| [p.ball.shot_count, p.grouping.play_order] }.
        inject(1) { |order, player| player.grouping.update!(play_order: order); order + 1 }
    end
end
