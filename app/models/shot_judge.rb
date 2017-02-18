class ShotJudge < ActiveRecord::Base
  belongs_to :shot

  # FIXME: Handle 'or', hash
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
  # [0] "{'1-3' => 'Save, LI Layup', '4-6' => 'Save, FW'}",
  # [1] "{'1-3' => 'Save, LI', '4-6' => 'Save, LI Layup (-1)'}",
  # [2] "{'1-3' => 'Save, LI', '4-5' => 'Save, MI', '6' => 'Save, SI'}",
  # [8] "{'1-2' => 'Save, SI', '3-4' => 'Save, P', '5-6' => 'LI (-5)'}"
  # [3] "{'1-3' => 'MI', '4-6' => 'SI'}",
  #
  # [4] "{'1-2' => 'P (-8)', '3-6' => 'P'}",
  # [5] "{'1-3' => 'P', '4-6' => 'Ch'}",
  # [6] "{'1-2' => 'P', '3-6' => 'Ch'}",
  # [7] "{'1-3' => 'SI', '4-6' => 'Ch'}",
end
