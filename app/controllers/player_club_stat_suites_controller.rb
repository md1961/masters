class PlayerClubStatSuitesController < ApplicationController

  def show
    @stat_suite = PlayerClubStatSuite.new(Player.all)
  end
end
