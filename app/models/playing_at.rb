# TODO: The class is probably unnecessary.
class PlayingAt < ActiveRecord::Base
  belongs_to :tournament
  belongs_to :hole
  has_one :group

  enum location: {tee: 0, fairway: 1, layup: 2, green: 3}

  H_LOCATIONS = {
    '3' => %w(tee green),
    '4' => %w(tee fairway green),
    '5' => %w(tee fairway layup green),
  }

  def self.create_all_for(tournament)
    seq_num = 1
    Hole.order(:number).each do |hole|
      H_LOCATIONS[hole.par.to_s].each do |location|
        tournament.playing_ats.create!(hole: hole, seq_num: seq_num, location: location.to_sym)
        seq_num += 1
      end
    end
  end
end
