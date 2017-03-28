class TournamentsController < ApplicationController

  def index
    if Tournament.count == 0
      redirect_to new_tournament_path
    else
      redirect_to Tournament.order(:created_at).last
    end
  end

  def show
    @tournament = Tournament.find(params[:id])
    round = @tournament.current_round
    if round.nil? || params[:has_cut_off] == 'true'
      redirect_to @tournament.new_round!
    elsif round.finished? && !round.final_round?
      redirect_to cut_off_path(tournament_id: @tournament)
    elsif !round.finished?
      redirect_to round
    elsif !round.playoff? && @tournament.leaders.size >= 2
      redirect_to @tournament.playoff
    else
      @players = @tournament.players_to_play.sort_by(&:leader_sorter)
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
