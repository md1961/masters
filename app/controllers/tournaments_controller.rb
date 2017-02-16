class TournamentsController < ApplicationController

  def index
    if Tournament.count == 0
      redirect_to new_tournament_path
    else
      # FIXME: Redirect_to last created, or show a list.
      redirect_to Tournament.last
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    round = @tournament.current_round
    if round.nil? || (round.finished? && !round.final_round?)
      redirect_to @tournament.new_round!
    elsif !round.finished?
      redirect_to round
    else
      @tournament.finish
      render text: "#{@tournament} finished"
    end
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new
    player_ids = params[:player].select { |_id, bool| bool == 'true' }.keys.map(&:to_i)
    if @tournament.update(tournament_params) && !player_ids.empty?
      @tournament.update!(players: Player.find(player_ids))
      redirect_to @tournament
    else
      render :new
    end
  end

  private

    def tournament_params
      params.require(:tournament).permit(:year, :name, :num_rounds)
    end
end
