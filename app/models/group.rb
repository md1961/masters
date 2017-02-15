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
    !round_finished? && !players_split? && area && area.next.open?
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

  def round_finished?
    players.all? { |player| player.ball.nil? }
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
      hole_number += 1
      hole_number = 1 if hole_number == 19
      # FIXME: Add attribute starting_hole to Round
      starting_hole = 1
      if hole_number == starting_hole
        finish_round
      else
        tee_up_on(hole_number)
      end
      []
    else
      player = next_player
      ball = player.ball
      is_putting = true if ball.on_green?
      info = player.play(index_option: index_option)
      @message = ball.direct_in? ? 'IN!' : is_putting ? 'miss' : nil
      hole = player.shot.hole
      next_shot = "( next will be: #{ball.next_shot_display} )"
      [hole.full_desc, ball.result_display, next_shot, info]
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

    def finish_round
      players.each { |player| player.update!(ball: nil) }
    end
end
