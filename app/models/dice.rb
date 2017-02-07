class Dice
  cattr_accessor :enforce

  def self.roll
    return @@enforce % 6 + 1 if @@enforce
    rand(1 .. 6)
  end

  def self.two_rolls
    return @@enforce if @@enforce
    d1 = roll
    d2 = roll
    d1, d2 = d2, d1 if d1 > d2
    d1 * 10 + d2
  end
end
