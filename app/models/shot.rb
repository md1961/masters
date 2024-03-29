class Shot < ApplicationRecord
  include Comparable

  belongs_to :hole
  belongs_to :area
  has_many :shot_judges
  has_many :balls
  has_many :players, through: :balls

  def self.first_tee(hole_number = 1)
    find_by(hole: Hole.find_by(number: hole_number), number: 1)
  end

  def judge(result)
    shot_judges.find_by(prev_result: look_up_in_prev_result(result))
  end

  def next(ball)
    ball.on_green? \
      ? Shot.where(hole: hole).order(:number).last \
      : Shot.find_by(hole: hole, number: number + 1, is_layup: ball.is_layup) || self
  end

  def destroy
    raise "Cannot destroy a Shot"
  end

  def <=>(other)
    if self.hole != other.hole
      self.hole <=> other.hole
    else
      self.number <=> other.number
    end
  end

  def to_s
    "shot##{number}#{is_layup ? '(layup)' : ''}"
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
