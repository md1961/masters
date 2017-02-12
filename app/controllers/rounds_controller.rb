class RoundsController < ApplicationController

  def index
    Round.destroy_all
    Ball .destroy_all
    redirect_to Round.create!(number: 1)
  end

  def show
    @round = Round.find(params[:id])
    @round.proceed
  end
end
