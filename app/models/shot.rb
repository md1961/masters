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
    shot_judges.find_by(prev_result: look_up_in_prev_result(result))
  end

  def next(is_layup)
    Shot.find_by(hole: hole, number: number + 1, is_layup: is_layup) || self
  end

  private

    def look_up_in_prev_result(result)
      return result unless result
      value = result.sub(/\*\z/, '')
      prev_results = shot_judges.pluck(:prev_result)
      if is_layup && (result == 'IN' || result.to_i > 0)
        results = prev_results.select { |r| r.to_i > 0 }
        value = results.find { |r| result.to_i <= r.split('-').last.to_i }
        value = results.last unless value
      elsif !prev_results.include?(result) && result =~ /\A[SML][LRC]-(Ch|P)\z/
        suffix = Regexp.last_match(1)
        re_result = /\AAll (:?other )?#{suffix}\z/
        value = prev_results.find { |r| r =~ re_result }
        raise StandardError, "Cannot find result matching #{re_result} in #{prev_results.inspect}" unless value
      end
      value
    end
end
