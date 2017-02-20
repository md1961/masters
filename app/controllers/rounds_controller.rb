class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :update]

  def show
    @message = params[:message]
    distance = @round.current_group.next_player.ball.result.to_i
    @time_to_delay = distance * 30 + 500
  end

  def update
    if @round.finished?
      redirect_to @round.tournament
    elsif params[:choosing_next_use] && params[:shot_option].nil?
      render :show
    else
      @round.proceed(shot_option: params[:shot_option])
      redirect_to round_path(@round, message: @round.message)
    end
  end

  private

    def set_round
      begin
        @round = Round.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to tournaments_path
      end
    end
end
