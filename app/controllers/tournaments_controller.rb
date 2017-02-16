class TournamentsController < ApplicationController

  def index
    # FIXME: Redirect_to last created, or show a list.
    redirect_to Tournament.last
  end

  def show
    @tournament = Tournament.find(params[:id])
    round = @tournament.current_round
    if round.nil?
      @tournament.start
    elsif !round.finished?
      redirect_to round
    elsif round.final_round?
      @tournament.finish
      render text: "#{@tournament} finished"
    else
      ActiveRecord::Base.transaction do
        begin
          round.update!(is_current: false)
          redirect_to @tournament.rounds.create!(number: round.number + 1, is_current: true)
        rescue => e
          raise 'Failed to advance to next round due to: ' + e.message
        end
      end
    end
  end

  def new
    @tournament = Tournament.new
  end

  def create
    @tournament = Tournament.new
    player_ids = params[:player].select { |_id, bool| bool == 'true' }.keys.map(&:to_i)
    if @tournament.update(tournament_params) && !player_ids.empty?
      @tournament.players = Player.find(player_ids)
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
