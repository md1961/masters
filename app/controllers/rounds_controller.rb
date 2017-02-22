class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :update]

  def show
  end

  def update
    if @round.finished?
      redirect_to @round.tournament
    elsif params[:choosing_next_use] && params[:shot_option].nil?
      render :show
    else
      @round.proceed(shot_option: params[:shot_option])
      @message = @round.message
      distance = @round.current_group.next_player.ball.result.to_i
      @time_to_delay = distance * 30 + 500
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
