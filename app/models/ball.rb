class Ball < ApplicationRecord
  include Comparable

  belongs_to :player, optional: true
  belongs_to :shot  , optional: true

  attr_accessor :club_used
  attr_reader :info

  after_create :set_next_use_if_nil

  # FIXME: Add COLUMN club_id(club_used_id), shot_judge_id.
  # TODO: Add COLUMN arbitrary_distance_factor.

  # TODO: Use enum instead of KEYWORD_FOR_FINISH_ROUND and finish_round!().
  KEYWORD_FOR_FINISH_ROUND = 'FINISHED'.freeze

  def finish_round!
    self.shot = nil
    self.result = "#{KEYWORD_FOR_FINISH_ROUND} #{player.round}"
    save!
  end

  def finished_round?
    result && result.start_with?(KEYWORD_FOR_FINISH_ROUND)
  end

  def hole
    shot.try(:hole)
  end

  def holed_out?
    result == 'IN' || result == 'OK'
  end

  def direct_in?
    result == 'IN'
  end

  def on_green?
    result.to_i > 0 || holed_out?
  end

  def ok?
    result&.end_with?('OK')
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

  def going_for_green?
    !on_green? && !(shot&.hole&.par >= 4 && shot&.number == 1) && !is_layup
  end

  def going_for_green_in_two?
    shot&.hole&.par == 5 && shot&.number == 2 && !is_layup && shot_count == 1
  end

  def next_use_optional?
    next_use =~ / or /
  end

  def next_use_options
    next_use.split(' or ').map { |s| s + (!next_adjust.zero? ? format(' (%+d)', next_adjust) : '') }
  end

  def accept(club_result)
    self.next_adjust = 0
    self.is_saved = false
    @info = ''
    if !shot.is_layup && (%w(IN OK).include?(club_result) || club_result.to_i > 0)
      self.result      = club_result
      self.lands       = 'Green'
      self.next_use    = 'Putt'
      self.shot_count += 1 if club_result == 'OK'
      self.shot = shot.next(self)
    else
      shot_judge = shot.judge(club_result)
      if is_layup && !%w[Trees Water].include?(shot_judge.lands)
        club_result.sub!(/\A[SML][LCR]-/, '')
        club_result = 'layup-' + club_result
      end
      self.result      = club_result
      self.lands       = shot_judge.lands
      self.next_use    = shot_judge.next_use
      self.next_adjust = shot_judge.next_adjust
      self.is_layup = false
      decide_optional_lands
      parse_next_use
      self.shot_count += 1 if lands == 'Water'
    end
    player.info += (player.info.blank? ? '' : '; ') + @info if @info.present?
  end

  def choose_next_use(index)
    return unless next_use_optional?
    self.next_use = next_use.split(' or ')[index]
    parse_next_use
  end

  RE_RESULT_LAYUP_NUMBERED = /\Alayup-(\d{1,2})\z/

  def <=>(other)
    if other.nil? || !other.is_a?(Ball)
      -1
    elsif self.shot != other.shot
      self.shot <=> other.shot
    elsif self.result.nil? && other.result.nil?
      self.player.grouping.play_order <=> other.player.grouping.play_order
    elsif self.result.nil?
      -1
    elsif other.result.nil?
      1
    elsif self.next_use_distance_factor != other.next_use_distance_factor
      other.next_use_distance_factor <=> self.next_use_distance_factor
    elsif (m1 = self .result.match(RE_RESULT_LAYUP_NUMBERED)) \
       && (m2 = other.result.match(RE_RESULT_LAYUP_NUMBERED))
      m2[1].to_i <=> m1[1].to_i
    else
      df_self  = result_distance_factor(self .result)
      df_other = result_distance_factor(other.result)
      if df_self != df_other
        df_self <=> df_other
      # TODO: Order randomly if equal, but needs to remember the ordering.
      else
        self.next_adjust <=> other.next_adjust
      end
    end
  end

  def self.result_name(diff)
    %w(par bogey double-bogey triple-bogey +4 +5 +6 +7 +8 +9 +10 DOUBLE-EAGLE EAGLE Birdie)[diff]
  end

  def hole_result(offset = 0)
    diff = shot_count - shot.hole.par + offset
    Ball.result_name(diff)
  end

  def result_w_info
    if @shows_info
      result
    elsif result.to_i > 0
      result.to_i.to_s
    else
      result&.sub(/\*\z/, '')
    end
  end

  def result_display
    if shot_count == 0
      ''
    elsif (ok? && @shows_info) || result == 'OK'
      "#{player} putt to OK to hole out on #{shot_count}. #{hole_result}"
    elsif holed_out?
      verb = club_used.putt? ? 'sunk' : 'shot DIRECTLY'
      "#{player} #{verb} into the hole out on #{shot_count}. #{hole_result}"
    elsif club_used.putt?
      "#{player} putt as #{shot_count.ordinalize} shot to #{result_w_info}"
    elsif is_saved
      "#{player} hit #{(shot_count - 1).ordinalize} shot into Deep #{lands} by '#{result}', " \
        "SAVE on #{shot_count.ordinalize} shot"
    else
      preposition = ['Trees', 'Sand', 'Water', 'Fairway Trap'].include?(lands) ? 'into' : 'onto'
      superlative = result&.end_with?('*') && @shows_info ? ' (superlative)' : ''
      "#{player} hit #{(shot_count - (lands == 'Water' ? 1 : 0)).ordinalize} shot" \
        " #{preposition} #{lands} by '#{result_w_info}'#{superlative}" \
        "#{lands == 'Water' ? ' , takes 1 penalty' : ''}"
    end
  end

  def next_shot_display(informative = false)
    next_adjust_display = next_adjust.zero? ? '' : "(#{next_adjust > 0 ? '+' : ''}#{next_adjust})"
    if informative
      "#{next_use}#{is_layup ? ' Layup' : ''} #{next_adjust_display}"
    elsif on_green?
      ''
    else
      from = lands.blank? ? '' : lands == 'Water' ? 'from Water Fringe' : "from #{lands}"
      "#{(shot_count + 1).ordinalize} shot #{from}" \
        " with #{next_use} #{next_adjust.zero? ? '' : next_adjust_display}" \
        " #{going_for_green_in_two? ? 'for Green in Two' : is_layup ? 'for Layup ' : ''}"
    end
  end

  H_NEXT_USE_DISTANCE_FACTOR = {
    "Drive" => 100,
    "FW"    =>  90,
    "LI"    =>  80,
    "MI"    =>  70,
    "SI"    =>  60,
    "P"     =>  50,
    "Sd"    =>  40,
    "Ch"    =>  40,
  }

  def next_use_distance_factor
    H_NEXT_USE_DISTANCE_FACTOR[next_use].to_i + (is_layup ? 1000 : 0)
  end

  def self.look_up_optional_result(hash, num)
    hash.find { |k, _v| num == k.to_i || num.between?(*(k.split('-').map(&:to_i))) }[1]
  end

  private

    RE_STRINGIFIED_HASH = /\A{.*}\z/

    def decide_optional_lands
      return unless lands =~ RE_STRINGIFIED_HASH
      dice = Dice.roll
      lands_orig = lands
      self.lands = Ball.look_up_optional_result(eval(lands), dice)
      @info = "'#{lands}' on dice #{dice} from #{lands_orig}"
      return unless next_use =~ RE_STRINGIFIED_HASH
      decide_optional_next_use(dice)
    end

    def decide_optional_next_use(dice = nil)
      dice = Dice.roll unless dice
      next_use_orig = next_use
      self.next_use = Ball.look_up_optional_result(eval(next_use), dice)
      @info += (@info.present? ? ', ' : '') + "'#{next_use}' on dice #{dice} from #{next_use_orig}"
    end

    def parse_next_use
      if next_use =~ RE_STRINGIFIED_HASH
        decide_optional_next_use
      end
      if next_use =~ /\ASave, (\w.*)\z/
        self.next_use = Regexp.last_match(1)
        self.shot_count += 1
        self.is_saved = true
      end
      if !next_use_optional? && next_use.sub!(/ \(([+-]?\d{1,2})\)\z/, '')
        self.next_adjust += Regexp.last_match(1).to_i
      end
      if next_use =~ /\A([A-Z]{2}) Layup\z/
        self.next_use = Regexp.last_match(1)
        self.is_layup = true
      end
    end

    def set_next_use_if_nil
      if shot&.hole&.number == 12 && shot&.number == 1
        self.next_use = player.round.club_name_for_12_tee
      else
        shot_judges = shot.shot_judges
        self.next_use = shot_judges.first.next_use if next_use.nil? && shot_judges.size == 1
      end
      save!
    end

    def result_distance_factor(result)
      if finished_round?
        H_DISTANCE_FACTOR['IN'] + 100
      elsif result.to_i > 0
        1000 - result.to_i
      elsif result =~ RE_RESULT_LAYUP_NUMBERED
        -800 - Regexp.last_match(1).to_i
      else
        raise "Cannot find key of '#{result}' in H_DISTANCE_FACTOR" unless H_DISTANCE_FACTOR.key?(result)
        H_DISTANCE_FACTOR[result]
      end
    end

    H_DISTANCE_FACTOR = {
      "IN"       => 100000,
      "OK"       => 10000,
      "Sd"       => -10,
      "LC-Ch"    => -100,
      "LL-Ch"    => -200,
      "LR-Ch"    => -300,
      "ML-Ch"    => -400,
      "MR-Ch"    => -500,
      "SC-Ch"    => -600,
      "SL-Ch"    => -700,
      "SR-Ch"    => -800,
      "SC-P"     => -1000,
      "SL-P"     => -2000,
      "SR-P"     => -3000,
      "layup-Ch" => -4000,
      "layup-P"  => -5000,
      "LC*"      => -10100,
      "LC"       => -10200,
      "LL"       => -10300,
      "LR"       => -10400,
      "MC*"      => -10500,
      "MC"       => -10600,
      "ML"       => -10700,
      "MR"       => -10800,
      "SC*"      => -10900,
      "SC"       => -11000,
      "SL"       => -11100,
      "SR"       => -11200,
    }
end
