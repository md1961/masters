class RoundsController < ApplicationController
  before_action :set_round, only: [:show, :update]

  def index
    Round.destroy_all
    Ball .destroy_all
    redirect_to Round.create!(number: 1)
  end

  def show
  end

  def update
    @round.proceed
    redirect_to @round
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
