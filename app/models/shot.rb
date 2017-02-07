class Shot < ActiveRecord::Base
  belongs_to :hole
  has_many :shot_judges
  has_many :balls
  has_many :players, through: :balls

  def self.first_tee
    find_by(hole: Hole.find_by(number: 1), number: 1)
  end

  def judge(result)
    # TODO: Tons of more to do.
    if result
      result = result.sub(/\*\z/, '')
    end

    shot_judges.find_by(prev_result: result)
  end

  def next
    Shot.find_by(hole: hole, number: number + 1, is_layup: false)
  end
end
