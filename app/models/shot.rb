class Shot < ActiveRecord::Base
  belongs_to :hole
  has_many :shot_judges
  has_many :balls
  has_many :players, through: :balls

  # TODO: Remove argument hole_number.
  def self.first_tee(hole_number = 1)
    find_by(hole: Hole.find_by(number: hole_number), number: 1)
  end

  def judge(result)
    # TODO: Tons of more to do.
    if result
      result = result.sub(/\*\z/, '')
      prev_results = shot_judges.pluck(:prev_result)
      if !prev_results.include?(result) && result =~ /\A[SML][LRC]-(Ch|P)\z/
        suffix = Regexp.last_match(1)
        re_result = /\AAll (:?other )?#{suffix}\z/
        result = prev_results.find { |r| r =~ re_result }
        raise StandardError, "Cannot find result matching #{re_result} in #{prev_results.inspect}" unless result
      end
    end

    shot_judges.find_by(prev_result: result)
  end

  def next
    # TODO: Choice whether layup or not on par 5's.
    Shot.find_by(hole: hole, number: number + 1, is_layup: false) || self
  end
end
