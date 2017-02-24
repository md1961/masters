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
      @distance = 0
      if @message&.sub!(/ from (\d+) to (\S+)/, '')
        @distance = Regexp.last_match(1).to_i
        @result   = Regexp.last_match(2)
      end
      @time_to_delay = @distance.zero? ? 2000 : @distance * 30 + 500
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
