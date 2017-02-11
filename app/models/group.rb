class Group < ActiveRecord::Base
  belongs_to :round
  belongs_to :area
  has_many :groupings, -> { order(:play_order) }
  has_many :players, through: :groupings

  def tee_up_on(hole_number)
    shot = Shot.first_tee(hole_number)
    area = round.areas.detect { |area| area.shots.include?(shot) }
    update!(area: area)
    players.each { |player| player.create_ball!(shot: shot) }
  end

  def next_player
    players.sort_by { |p| [p.shot, p.play_order] }.first
  end

  def to_s
    "#{next_player}(Group ##{number}, w/#{(players - [next_player]).join(', ')})"
  end
end
