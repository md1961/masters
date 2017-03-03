class CutOffsController < ApplicationController

  def show
    tournament = Tournament.find(params[:tournament_id])
    round = tournament.current_round
    @players = tournament.players.sort_by { |player|
      strokes_last_first = player.score_cards.find_by(round: round).scores.pluck(:value).reverse
      [player.tournament_score, strokes_last_first]
    }
    @cut_off_score = @players.first.tournament_score + 10
  end
end
