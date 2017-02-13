class Group < ActiveRecord::Base
  belongs_to :round
  has_many :groupings, -> { order(:play_order) }
  has_many :players, through: :groupings

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

  def tee_up_on(hole_number)
    shot = Shot.first_tee(hole_number)
    players.each { |player| player.create_ball!(shot: shot) }
  end

  def next_player
    players.sort_by { |p| [p.ball, p.play_order] }.first
  end

  def play
    if !all_holed_out?
      player = next_player
      info = player.play
      hole = player.shot.hole
      s = "#{player.last_name} on #{hole} (Par #{hole.par})"
      [s, player.ball.result_display, player.ball.next_shot_display, info]
    else
      # TODO: Update play_order of Grouping.
      hole_number = players.first.shot.hole.number
      # TODO: Modify end of round procedure.
      return :end_of_round if hole_number == 18
      hole_number += 1
      tee_up_on(hole_number)
      ["#{self} tee up on #{Hole.find_by(number: hole_number)}"]
    end
  end

  def ==(other)
    self.number == other.number
  end

  def to_s
    "#{next_player}(Group ##{number})"
  end
end
