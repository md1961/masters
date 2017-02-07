class Dice

  def self.roll
    rand(1 .. 6)
  end

  def self.two_rolls
    d1 = roll
    d2 = roll
    d1, d2 = d2, d1 if d1 > d2
    d1 * 10 + d2
  end
end
