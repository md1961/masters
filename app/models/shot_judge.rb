class ShotJudge < ActiveRecord::Base
  belongs_to :shot

  # FIXME: Handle 'or', hash
  def to_s
    "#{next_use} (#{format('%+d', next_adjust).sub('+0', '0')})"
  end
end
