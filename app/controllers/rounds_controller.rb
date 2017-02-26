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
          @pre_messages = ["#{location} from which to putt..."]
          @message = ''
        else
          @pre_messages = ["from #{location}..."]
          case @round.club_name_used.downcase
          when 'drive'
            @result.sub!(/-([SML][LRC])\z/, '')
            carry, direction = Regexp.last_match(1).split('')
            @result += " for #{{S: :Short, M: :Medium, L: :Long}[carry.to_sym]}"
            @pre_messages << (direction == 'L' ? 'Pulling left...' \
                            : direction == 'R' ? 'Pushing right...' \
                                               : 'Heading center...')
          when 'fw', 'li', 'mi', 'si'
            @pre_messages << 'Heading toward green...' \
          end
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

    def set_round
      begin
        @round = Round.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to tournaments_path
      end
    end
end
