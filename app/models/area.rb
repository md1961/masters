class Area < ActiveRecord::Base
  belongs_to :round
  has_many :shots

  enum name: {tee: 0, fairway: 1, layup: 2, green: 3}

  H_LOCATIONS = {
    '3' => %w(tee green),
    '4' => %w(tee fairway green),
    '5' => %w(tee fairway layup green),
  }

  def self.create_all_for(round)
    @round = round
    @seq_num = 1
    Hole.order(:number).each do |hole|
      create_for(:tee    , hole.shots.where(number: 1))
      create_for(:fairway, hole.shots.where(number: 2)) if hole.par >= 4
      create_for(:green  , hole.shots.where(number: hole.par == 3 ? [2, 3] :[3, 4]))
    end
  end

  def self.create_for(name, shots)
    @round.areas.create!(seq_num: @seq_num, name: name).tap do |area|
      shots.each { |shot| shot.update!(area: area) }
      @seq_num += 1
    end
  end

  def hole
    shots.first.hole
  end

  def final?
    hole.number == round.final_hole_number && green?
  end

  def open?
    shots.flat_map(&:players).none? { |player| player.round == round }
  end

  def prev
    round.areas.find_by(seq_num: seq_num - 1)
  end

  def next
    round.areas.find_by(seq_num: seq_num + 1)
  end

  def to_s
    name.capitalize
  end
end
