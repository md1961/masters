class ShotJudge < ActiveRecord::Base
  belongs_to :shot

  # FIXME: Handle 'or', hash
  def to_s
    next_adjust = \
      if next_adjust.nil? || next_adjust.zero?
        ''
      else
        " (#{format('%+d', next_adjust)})"
      end
    "#{next_use}#{next_adjust}"
  end
end
