class Ball < ActiveRecord::Base
  belongs_to :player
  belongs_to :shot

  def holed_out?
    result == 'IN'
  end

  def ok?
    result == 'OK'
  end

  def second_putt?
    result =~ /\A\d{1,2}s\z/
  end

  def third_putt?
    result =~ /\A1t\z/
  end

  def superlative?
    result =~ /\*\z/
  end
end
