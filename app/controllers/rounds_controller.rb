class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :update]

  def show
  end

  def update
    if @round.finished?
      redirect_to @round.tournament
    elsif params[:choosing_next_use] && params[:shot_option].nil?
      render :shot_option
    else
    # FIXME: Handle for when @round#needs_input?
      @round.proceed(shot_option: params[:shot_option])
      prepare_messages
    end
  end

  private

    MININUM_DISTANCE_TO_ANINATE = 3
    TIME_TO_DELAY_FOR_MESSAGE = 1200

    def prepare_messages
      @message_orig = @round.message&.dup

      @message = @round.message
      @distance = 0
      @pre_messages = []
      if @message&.sub!(Group::RE_ADDITIONAL_MESSAGE, '')
        location = Regexp.last_match(1)
        @result  = Regexp.last_match(2)
        if location.to_i > 0
          @distance = location.to_i
          @pre_messages = ["#{location} to putt..."]
          @message = ''
        else
          add_pre_messages_off_green
          if %w(IN OK).include?(@result) || @result.to_i > 0
            @distance = @result.to_i + rand(1 .. 20)
            @pre_messages << "#{@distance} ..."
            @message = ''
          else
            @message = @result
          end
        end
      else
        @message = nil
      end
      if @distance < MININUM_DISTANCE_TO_ANINATE
        @distance = 0
        @message = @result
      end
      @time_to_delay = TIME_TO_DELAY_FOR_MESSAGE
    end

    H_MESSAGES_OFF_GREEN = {SC: 'Looking short...', LC: 'Looking long...',
                            ML: 'Going left...'   , MR: 'Going right...'}

    def add_pre_messages_off_green
      @result.sub!(/-([SML][LRC])\z/, '')
      carry, direction = Regexp.last_match(1)&.split('')
      case @round.club_name_used.downcase
      when 'drive'
        @result += " for #{{S: :Short, M: :Medium, L: :Long}[carry.to_sym]}"
        @pre_messages << {L: 'Pulling left...', R: 'Pushing right...', C: 'Heading center...'}[direction.to_sym]
      when 'fw', 'li', 'mi', 'si'
        if carry.nil?
          @pre_messages << \
            if @result == 'IN' || @result.to_i <= rand(10 .. 20)
              'Heading directly to the flag...'
            elsif @result.to_i <= rand(25 .. 35) || Dice.roll >= 5
              'Heading toward green...'
            else
              H_MESSAGES_OFF_GREEN.values.sample
            end
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
      end
    end

    def set_round
      begin
        @round = Round.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to tournaments_path
      end
    end
end
