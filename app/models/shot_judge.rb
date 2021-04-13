class ShotJudge < ApplicationRecord
  belongs_to :shot

  def to_s
    next_use_display = next_use
    if next_use.start_with?('{')
      h = eval(next_use)
      next_use_display = \
        if h.values.first.start_with?('Save')
          'Save'
        else
          h.values.join(',').gsub(' ', '')
        end
    end
    next_adjust_display = \
      next_adjust.nil? || next_adjust.zero? ? '' : " (#{format('%+d', next_adjust)})"
    "#{next_use_display}#{next_adjust_display}"
  end
end
