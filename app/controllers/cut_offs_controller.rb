class CutOffsController < ApplicationController
  before_action :set_players

  def show
    @is_confirming = params[:confirm] == 'true'
    @index_just_made = params[:index_just_made]&.to_i
    @cut_off_score = @is_confirming ? nil : @players.first.tournament_score + 10
  end

  def update
    tournament = Tournament.find(session[:tournament_id_for_cut_offs])
    session[:tournament_id_for_cut_offs] = nil
    index_just_made = params[:index_just_made].to_i
    ActiveRecord::Base.transaction do
      begin
        @players[index_just_made + 1, @players.size].each do |player|
          tournament.cut_off!(player)
        end
      rescue StandardError
        raise
      end
    end
    redirect_to tournament_path(tournament, has_cut_off: true)
  end

  def confirm_update
    index_just_made = params[:index_just_made]&.to_i
    index_just_made += 1 if index_just_made&.even?
    index_just_made = @players.size - 1 if index_just_made.nil?
    redirect_to cut_off_path(confirm: true, index_just_made: index_just_made)
  end

  private

    def set_players
      tournament_id = params[:tournament_id] || session[:tournament_id_for_cut_offs]
      session[:tournament_id_for_cut_offs] = tournament_id

      tournament = Tournament.find(tournament_id)
      round = tournament.current_round
      @players = tournament.players_to_play.sort_by { |player|
        strokes_last_first = player.score_cards.find_by(round: round).scores.pluck(:value).reverse
        [player.tournament_score, strokes_last_first]
      }
    end
end
