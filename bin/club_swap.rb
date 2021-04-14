player1, player2 = %w[
  Nicklaus
  Lietzke
].map { |last_name|
  Player.find_by(last_name: last_name).tap { |player|
    unless player
      STDERR.puts "Cannot find player '#{last_name}'"
      exit
    end
  }
}

club_names = %w[fw li mi si p ch putt]

ApplicationRecord.transaction do
  club_names.each do |name|
    club1 = player1.clubs.find_by(name: name)
    raise "Cannot find club '#{name}' for #{player1}" unless club1
    club2 = player2.clubs.find_by(name: name)
    raise "Cannot find club '#{name}' for #{player2}" unless club2

    club1.player = player2
    club2.player = player1
    club1.save!(validate: false)
    club2.save!(validate: false)
  end
end
