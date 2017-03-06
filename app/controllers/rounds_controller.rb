class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :update]

  def show
  end

  def update
    if @round.finished?
      redirect_to @round.tournament
    elsif params[:choosing_next_use] && params[:shot_option].nil?
      render :choose_shot_option
    else
      @round.proceed(shot_option: params[:shot_option])
      prepare_messages unless @no_animation
    end
  end

  private

    TIME_TO_DELAY_FOR_MESSAGE = 1350

    def prepare_messages
      @message_orig = @round.message&.dup

      @result_message = ResultMessage.new(@round)
      @time_to_delay = TIME_TO_DELAY_FOR_MESSAGE
    end

    def set_round
      @round = Round.find(params[:id])
    end
end
