class PlayingAt < ActiveRecord::Base
  belongs_to :hole

  enum location: {tee: 0, fairway: 1, layup: 2, green: 3}
end
