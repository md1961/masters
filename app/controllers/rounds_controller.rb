class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :update]

  def index
    redirect_to Round.create!(number: 1)
  end

  def show
    session[:style] = params[:style] if params[:style]
    @style = session[:style]
  end

  def update
    # TODO: Maybe this block is needless.
    if params[:choosing_next_use] && params[:shot_option].nil?
      render :show
    else
      @round.proceed(shot_option: params[:shot_option])
      redirect_to @round
    end
  end

  private

    def set_round
      begin
        @round = Round.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        redirect_to rounds_path
      end
    end
end
