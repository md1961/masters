class ClubsController < ApplicationController

  def index
    @clubs_by_name = Club.all.group_by { |club| club.name }.tap { |h|
      h.each do |name, clubs|
        clubs.uniq!
      end
    }
  end
end
