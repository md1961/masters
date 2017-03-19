class Playoff < Round
  before_create :set_number_to_current_plus_one

  def playoff?
    true
  end

  def final_round?
    true
  end

  HOLE_NUMBERS = [18, 10]

  def first_hole_number
    HOLE_NUMBERS.first
  end

  def final_hole_number
    nil
  end

  def next_hole_number(hole_number)
    index = HOLE_NUMBERS.index(hole_number) + 1
    HOLE_NUMBERS[index] || HOLE_NUMBERS.first
  end

  def to_be_finished?
    raise "Number of groups must be one (#{groups.size} given)" unless groups.size == 1
    group = groups.first
    return false unless group.all_holed_out?
    strokes = group.players.map(&:ball).map(&:shot_count)
    min_stroke = strokes.min
    strokes.find_all { |stroke| stroke == min_stroke }.size == 1
  end

  def to_s
    'Playoff'
  end

  private

    def set_number_to_current_plus_one
      self.number = tournament.num_rounds + 1
    end

    def setup_groups_and_score_cards
      Area.all.each { |area| area.update!(round: self) }

      players = tournament.leaders
      raise 'No Playoff needed!' if players.size <= 1
      players.sort_by! { rand }

      Grouping.destroy_all
      group = groups.create!(number: 1, players: players)
      players.each { |player| player.ball&.destroy }

      groups.first.tee_up_on(first_hole_number)

      players.each do |player|
        player.score_cards.create!(round: self)
      end
    end
end
