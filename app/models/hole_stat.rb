class HoleStat
  attr_reader :hole_number

  def self.build_all_from(tournament)
    hole_stats = 1.upto(18).map { |hole_number| new(hole_number) }
    scores = tournament.rounds.flat_map(&:score_cards).flat_map(&:scores)
    scores.each do |score|
      hole_stat = hole_stats[score.hole.number - 1]
      hole_stat.count_up(score.value - score.hole.par)
    end
    hole_stats
  end

  def initialize(hole_number)
    @hole_number = hole_number
    @h_score_count = Hash.new { |h, k| h[k] = 0 }
  end

  def count_up(score)
    @h_score_count[score] += 1
  end

  def count(score)
    @h_score_count[score]
  end

  def total_count
    @h_score_count.values.sum
  end

  def average
    total_score = @h_score_count.inject(0) { |total, (score, count)| 
      total += score * count
    }
    total_score.to_f / total_count
  end
end
