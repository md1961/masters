class ShotJudge < ActiveRecord::Base
  belongs_to :shot

  # FIXME: Handle 'or', hash
  def to_s
    next_adjust_display = \
      if next_adjust.nil? || next_adjust.zero?
        ''
      else
        " (#{format('%+d', next_adjust)})"
      end
    lands_display = case lands \
      when 'Fairway', 'Near Green'
        ''
      else
        "#{lands}, "
      end
    "#{lands_display}#{next_use}#{next_adjust_display}"
    "#{next_use}#{next_adjust_display}"
  end
end
