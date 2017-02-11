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

  def players_split?
    players_area_uniq.size > 1
  end

  def next_area_open?
    area = players_area_uniq.first
    !players_split? && area && area.next.open?
  end

  def tee_up_on(hole_number)
    shot = Shot.first_tee(hole_number)
    players.each { |player| player.create_ball!(shot: shot) }
  end

  def next_player
    players.sort_by { |p| [p.shot, p.play_order] }.first
  end

  def to_s
    "#{next_player}(Group ##{number}, w/#{(players - [next_player]).join(', ')})"
  end
end
