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
    elsif round.finished?
      if round.final_round?
        @tournament.finish
      else
        ActiveRecord::Base.transaction do
          begin
            round.update!(is_current: false)
            rounds.create!(number: round.number + 1, is_current: true)
          rescue => e
            raise 'Failed to advance to next round due to: ' + e.message
          end
        end
      end
    else
      redirect_to round
    end
  end
end
