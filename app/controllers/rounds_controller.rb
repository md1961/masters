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
      #@round.proceed(shot_option: params[:shot_option])


      from = 27
      to   = 'OK'
      @round.instance_variable_set('@message', "debugging... from #{from}")
      @round.current_group.next_player.ball.update!(result: to) # reset to 'OK'.


      @message = @round.message
      @distance = 0
      if @message&.sub!(/ from (\d+)/, '')
        @distance = Regexp.last_match(1).to_i
      end
      @time_to_delay = 1000 #@distance * 50 + 250
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
