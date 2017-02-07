class SecondPuttResult

  SECOND_PUTT_RESULTS = [
    #  Length of
    #  First Putt   A    B    C    D
    %w( 1-3        OK   OK   OK   OK ),
    %w( 4-6         1s  OK   OK   OK ),
    %w( 7-9         2s   1s  OK   OK ),
    %w(10-13        3s   2s   1s  OK ),
    %w(14-17        4s   3s   2s   1s),
    %w(18-21        5s   4s   2s   1s),
    %w(22-25        6s   4s   3s   2s),
    %w(26-30        7s   5s   3s   2s),
    %w(31-35        9s   6s   4s   2s),
    %w(36-40       11s   8s   5s   3s),
    %w(41-45       13s   9s   5s   3s),
    %w(46-50       14s  10s   6s   3s),
    %w(51-55       16s  12s   8s   5s),
    %w( 56+        18s  14s  10s   5s),
  ]
  # Third putt is missed only if rolls 11.
  # Fourth putt is automatically sunk.

  def self.get(ball_on, suffix)
    index = suffix.ord - 'A'.ord
    SECOND_PUTT_RESULTS.find do |range, *results|
      break results[index] if range.end_with?('+')
      max = range.split('-').last.to_i
      break results[index] if ball_on <= max
    end
  end
end
