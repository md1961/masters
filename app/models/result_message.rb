class ResultMessage
  attr_accessor :message, :distance, :pre_messages, :result

  def initialize(round)
    @message = round.message
    @distance = 0
    @pre_messages = []
    @club_name_used = round.club_name_used&.downcase
    interpret_message
  end

  def not_nil?
    !@message.nil?
  end

  MININUM_DISTANCE_TO_ANINATE = 3
  MAXIMUM_DISTANCE = 60

  private

    def interpret_message
      is_putting = false
      if @message&.sub!(Group::RE_ADDITIONAL_MESSAGE, '')
        location = Regexp.last_match(1)
        @result  = Regexp.last_match(2)
        if location.to_i > 0
          is_putting = true
          @distance = location.to_i
          @result = '1' if @result == 'OK'
          @pre_messages = ["#{location} to putt...@1000"]
          @message = ''
        else
          @rolls_out_of_green = false
          @appears_off_green = false
          add_pre_messages_off_green
          if @result == 'IN' || @result.to_i > 0 || @rolls_out_of_green
            max_dice_to_roll_away = @result.to_i >= 50 ? 6 : @result.to_i >= 45 ? 5 : 4
            @result = "-#{@result}" if @result.to_i > 0 && Dice.roll <= max_dice_to_roll_away
            if @rolls_out_of_green
              @distance = rand(30 .. 50)
            else
              @distance = [@result.to_i + running_distance, MAXIMUM_DISTANCE].min
              @distance += 2 if @distance >= 0
              if @distance < @result.to_i
                @distance = -@distance
                @result = (-@result.to_i).to_s
              elsif @result.to_i <= -40 && @distance > 0
                @distance = -@distance
              end
            end
            @pre_messages << "#{@distance.abs} ...@1000"
            @message = ''
          else
            @message = @result
          end
        end
      else
        @message = nil
      end
      if is_putting && @distance < MININUM_DISTANCE_TO_ANINATE
        @distance = 0
        @message = @result
        @message = 'miss!' unless @message == 'IN'
      end
    end

    MAX_RUN_BY_CLUB = {
      fw: 30, li: 28, mi: 26, si: 24, ch: 20, p: 15, sd: 20
    }
    MIN_RUN_BY_CLUB = {
      fw: 15, li: 12, mi: 10, si:  8, ch:  5, p:  1, sd:  5
    }

    def running_distance
      max_run = MAX_RUN_BY_CLUB[@club_name_used.to_sym] - (@appears_off_green ? 10 : 0)
      min_run = MIN_RUN_BY_CLUB[@club_name_used.to_sym]
      rand(min_run .. max_run)
    end

    H_MESSAGES_OFF_GREEN = {SC: 'Looking short...', LC: 'Looking long...',
                            ML: 'Going left...'   , MR: 'Going right...'}
    MESSAGE_TO_GREEN = 'Heading toward green...'

    def add_pre_messages_off_green
      @result.sub!(/-([SML][LRC])(.*)\z/, '')
      supplement       = Regexp.last_match(2)
      carry, direction = Regexp.last_match(1)&.split('')
      case @club_name_used
      when 'drive'
        @result += " in #{{S: :Short, M: :Medium, L: :Long}[carry.to_sym]}"
        hard = carry == 'L' || (carry == 'M' && (supplement == '*' || Dice.roll >= 5)) ? ' Strongly' : ''
        @pre_messages << {
          L: "Pulling#{hard} left...",
          R: "Pushing#{hard} right...",
          C: "Straight#{hard} in Center...",
        }[direction.to_sym] + '@2000'
      when 'fw', 'li', 'mi', 'si'
        if carry.nil?
          @pre_messages << \
            if @result == 'IN' || @result.to_i <= rand(3 .. 20)
              'Heading directly to the flag...'
            elsif @result.to_i <= rand(25 .. 35) || Dice.roll >= 5
              MESSAGE_TO_GREEN
            else
              @appears_off_green = true
              H_MESSAGES_OFF_GREEN.values.sample
            end
        elsif supplement == '-P'
          @pre_messages << 'Looking WAY short...'
        elsif Dice.roll <= 2
          @pre_messages << MESSAGE_TO_GREEN
          @rolls_out_of_green = true
        else
          if %w(SL SR LL LR).include?(carry + direction)
            if Dice.roll <= 3
              carry = 'M'
            else
              direction = 'C'
            end
          end
          @pre_messages << H_MESSAGES_OFF_GREEN[(carry + direction).to_sym] || 'Off green ???'
        end
      when 'p'
        @pre_messages << 'High in the air...'
      else
        @pre_messages << 'In the air...@1000'
      end
    end
end
