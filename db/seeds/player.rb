SECOND_PUTT_RESULTS = [
  #  Length of
  #  First Putt   A    B    C    D
  %w( 1-3       GOOD GOOD GOOD GOOD),
  %w( 4-6         1  GOOD GOOD GOOD),
  %w( 7-9         2    1  GOOD GOOD),
  %w(10-13        3    2    1  GOOD),
  %w(14-17        4    3    2    1 ),
  %w(18-21        5    4    2    1 ),
  %w(22-25        6    4    3    2 ),
  %w(26-30        7    5    3    2 ),
  %w(31-35        9    6    4    2 ),
  %w(36-40       11    8    5    3 ),
  %w(41-45       13    9    5    3 ),
  %w(46-50       14   10    6    3 ),
  %w(51-55       16   12    8    5 ),
  %w( 56+        18   14   10    5 ),
]
# Third putt is missed only if rolls 11.
# Fourth putt is automatically sunk.


Player.destroy_all
Club.destroy_all
ClubResult.destroy_all

DICES = %w(11 12 13 14 15 16 22 23 24 25 26 33 34 35 36 44 45 46 55 56 66).map(&:to_i)

def add_clubs(player, h_clubs)
  h_clubs.each do |name, results|
    raise StandardError, "illeagl size #{results.size} for #{name} of #{player}" unless results.size == DICES.size
    club = player.clubs.create!(name: name)
    DICES.zip(results) do |dice, result|
      club.club_results.create!(dice: dice, result: result)
    end
  end
end

# If shot just after superlative drive land on green, rolls one dice and subtract it from distance.
# If it becomes exactly zero, the ball goes into the cup.
# (1) in 66 obtained unmodified: 1, 2 or 3 into the cup; 4, 5 or 6 lands 1 foot from the pin.
#   After superlative drive: 1, 2, 3 or 4 into the cup; 5 or 6 lands 1 foot from the pin.

=begin
player = Player.create!(last_name: 'Aoki', first_name: 'Isao', overall: 25)
h_clubs = {
  drive: %w(SL SR SL SC SC SC SC* SC ML MR ML ML MC MC MC MC* MC MC MC* LC LC*),
  fw:    %w(SC-P SR-P SL-P SC-P SR-Ch LC-Ch MR-Ch SL-Ch ML-Ch LL-Ch 50 41 34 30 28 25 20 16 12 8 6),
  li:    %w(SR-P SL-P SC-P SL-Ch MR-Ch LC-Ch LR-Ch SC-Ch ML-Ch 48 41 37 33 29 25 20 17 14 11 7 5),
  mi:    %w(SC-P MR-Ch LC-Ch SR-Ch LL-Ch ML-Ch LR-Ch 57 45 40 36 33 28 24 20 18 16 13 9 6 3),
  si:    %w(SR-Ch ML-Ch LR-Ch SC-Ch MR-Ch SL-Ch 50 39 35 32 27 24 22 19 16 13 11 8 6 4 2),
  p:     %w(SC-Ch MR-Ch SR-Ch 44 30 25 22 20 18 16 14 13 11 10 9 7 6 5 3 2 (1)),
  ch:    %w(52 36 26 18 14 12 11 10 9 8 7 6 5 5 4 4 3 2 2 1 IN),
  sd:    %w(Sd 36 24 20 17 14 12 10 9 8 7 7 6 6 5 4 4 3 2 1 IN),
  putt:  %w(Miss-A 1-B 2-C 3-D 3 4 4 5 6 7 8 9 10 12 13 16 20 26 42 IN IN),
}
add_clubs(player, h_clubs)
=end

player = Player.create!(last_name: 'Nicklaus', first_name: 'Jack', overall: 22)
h_clubs = {
  drive: %w(SL SR SC ML MR MC* MC MC MC MC MC MC* MC MC LR LL LC LC LC* LC LC*),
  fw:    %w(SL-P SR-P SC-Ch MR-Ch LL-Ch LC-Ch SR-Ch ML-Ch 54 45 38 35 28 25 22 19 16 12 9 5 3),
  li:    %w(SC-P MR-Ch ML-Ch SR-Ch LL-Ch SC-Ch LR-Ch 45 42 37 35 31 28 22 19 16 14 11 8 4 2),
  mi:    %w(SL-Ch SR-Ch ML-Ch LR-Ch LC-Ch MR-Ch 56 46 41 37 32 28 24 21 18 16 14 11 8 5 2),
  si:    %w(SL-Ch MR-Ch LC-Ch ML-Ch LL-Ch 51 37 32 29 27 23 21 19 17 14 12 10 7 5 3 1),
  p:     %w(SR-Ch SL-Ch LL-Ch 47 33 28 24 21 19 18 16 14 12 11 10 8 7 6 4 2 (1)),
  ch:    %w(54 39 30 20 16 13 12 11 10 9 8 7 6 6 5 4 4 3 2 1 IN),
  sd:    %w(Sd 50 35 32 28 22 19 15 13 12 11 10 9 8 7 6 5 4 3 2 (1)),
  putt:  %W(Miss-A 1-B 2-C 2-D 3 3 4 4 5 6 7 8 9 10 12 13 16 21 34 50 IN),
}
add_clubs(player, h_clubs)

player = Player.create!(last_name: 'Watson', first_name: 'Tom', overall: 22)
h_clubs = {
  drive: %w(SL SR SC ML MR ML MR ML MC MC MC MC* MC LL LR LC* LL LC LC* LC LC*),
  fw:    %w(SC-P SR-P SR-P SR-Ch LC-Ch MR-Ch SL-Ch ML-Ch LL-Ch 53 41 34 30 27 25 20 16 12 8 6 4),
  li:    %w(SL-P SC-P SL-Ch MR-Ch LC-Ch LR-Ch SC-Ch ML-Ch 49 40 37 33 29 25 20 17 14 11 7 5 3),
  mi:    %w(MR-Ch LL-Ch ML-Ch SR-Ch SL-Ch LC-Ch SC-Ch 50 42 37 34 29 25 22 19 16 14 10 6 4 2),
  si:    %w(SR-Ch SC-Ch MR-Ch LR-Ch ML-Ch SL-Ch 47 36 31 28 25 22 19 18 14 11 9 6 4 2 1),
  p:     %w(MR-Ch LL-Ch 44 28 20 18 17 16 14 13 12 11 10 8 7 6 5 3 2 1 (1)),
  ch:    %w(44 29 18 13 11 10 9 8 7 6 5 5 4 4 3 3 2 2 1 1 IN),
  sd:    %w(Sd 36 24 20 17 14 12 10 9 8 8 7 6 6 5 4 4 3 2 1 IN),
  putt:  %w(Miss-A 1-B 2-C 3-D 3 4 5 5 6 7 8 9 10 12 13 16 20 25 42 IN IN),
}
add_clubs(player, h_clubs)

player = Player.create!(last_name: 'Floyd', first_name: 'Ray', overall: 23)
h_clubs = {
  drive: %w(SL SR SC ML MR ML MC* MR MC MC MC MC* MC MC LR LL LR LC LC* LC LC*),
  fw:    %w(SL-P SC-P SR-P LC-Ch ML-Ch SR-Ch SC-Ch LR-Ch MR-Ch 54 42 37 30 27 25 21 18 14 11 7 4),
  li:    %w(SC-P SR-P LC-Ch SR-Ch ML-Ch SC-Ch LR-Ch MR-Ch 50 41 37 34 31 25 21 18 16 13 10 5 4),
  mi:    %w(SC-Ch MR-Ch LC-Ch SR-Ch LL-Ch ML-Ch LR-Ch 54 43 38 34 30 25 23 19 17 15 12 9 5 3),
  si:    %w(SC-Ch LR-Ch MR-Ch LC-Ch ML-Ch SR-Ch 48 37 32 29 25 22 20 18 15 13 10 8 5 3 1),
  p:     %w(MR-Ch LL-Ch 45 29 21 19 18 17 15 13 12 11 10 8 7 6 5 4 2 1 (1)),
  ch:    %w(45 30 20 14 11 10 9 8 7 6 6 5 4 4 3 3 2 2 1 1 IN),
  sd:    %w(Sd 38 27 23 19 16 13 11 10 9 8 7 7 6 5 5 4 3 2 1 IN),
  putt:  %w(Miss-A 1-B 2-C 3-D 3 4 5 5 6 7 8 9 10 11 13 16 19 25 41 IN IN),
}
add_clubs(player, h_clubs)

player = Player.create!(last_name: 'Strange', first_name: 'Curtis', overall: 24)
h_clubs = {
  drive: %w(SR SL SC SC SC SC SC* SC MR ML MC MR MC MC MC MC* MC MC MC* LC LC*),
  fw:    %w(SL-P SC-P SR-P LC-Ch ML-Ch SR-Ch SC-Ch LR-Ch MR-Ch 53 41 37 30 27 25 21 18 14 11 7 4),
  li:    %w(SC-P SR-P LC-Ch SR-Ch ML-Ch SC-Ch LR-Ch MR-Ch 49 40 37 34 31 25 21 18 16 13 10 5 4),
  mi:    %w(SC-Ch MR-Ch LC-Ch SR-Ch LL-Ch ML-Ch LR-Ch 53 42 38 34 30 25 23 19 17 15 12 9 5 3),
  si:    %w(SC-Ch LR-Ch MR-Ch LC-Ch ML-Ch SR-Ch 47 37 31 29 25 22 20 18 15 13 10 8 5 3 1),
  p:     %w(SC-Ch MR-Ch 47 31 22 20 19 18 16 14 13 12 11 9 8 6 5 4 3 1 (1)),
  ch:    %w(47 33 23 16 13 11 10 9 8 7 6 6 5 4 4 3 2 2 1 1 IN),
  sd:    %w(Sd 38 27 23 19 16 13 12 10 9 8 7 7 6 5 5 4 3 2 1 IN),
  putt:  %w(Miss-A 1-B 2-C 3-D 3 4 4 5 6 7 8 9 10 11 12 15 18 24 40 IN IN),
}
add_clubs(player, h_clubs)

player = Player.create!(last_name: 'Crenshaw', first_name: 'Ben', overall: 25)
h_clubs = {
  drive: %w(SL SR SC SC ML MR ML MR ML MR MC MC* MC MC MC MC* LL LR LC* LC LC*),
  fw:    %w(SL-P SC-P SR-P LC-Ch ML-Ch SR-Ch SC-Ch LR-Ch MR-Ch 53 41 37 30 27 25 21 18 15 11 7 4),
  li:    %w(SC-P SR-P LC-Ch SR-Ch ML-Ch SC-Ch LR-Ch MR-Ch 49 40 37 34 31 25 21 18 16 13 10 5 4),
  mi:    %w(SC-P ML-Ch SR-Ch LL-Ch SC-Ch LC-Ch MR-Ch 56 44 39 35 32 27 24 20 18 16 13 9 6 3),
  si:    %w(ML-Ch MR-Ch SC-Ch LR-Ch SL-Ch LC-Ch 49 38 34 31 26 24 22 19 17 13 11 8 6 4 2),
  p:     %w(MR-Ch LL-Ch 45 29 21 19 18 17 15 13 12 11 10 8 7 6 5 4 2 1 (1)),
  ch:    %w(45 30 20 14 11 10 9 8 7 6 6 5 4 4 3 3 2 2 1 1 IN),
  sd:    %w(Sd 36 24 20 17 14 12 10 9 8 7 7 6 6 5 4 4 3 2 1 IN),
  putt:  %w(Miss-A 1-B 2-C 3-D 3 4 4 5 6 7 8 9 10 11 13 16 19 25 41 IN IN),
}
add_clubs(player, h_clubs)

player = Player.create!(last_name: 'Stadler', first_name: 'Craig', overall: 24)
h_clubs = {
  drive: %w(SL SC MR ML MR MC ML MC MC MC MC MC* LL LR LL LC* LR LC LC* LC LC*),
  fw:    %w(SC-P SR-P SL-P SC-P SR-Ch LC-Ch MR-Ch SL-Ch ML-Ch LL-Ch 53 41 34 30 28 25 20 16 12 8 6),
  li:    %w(SR-P SL-P SC-P SL-Ch MR-Ch LC-Ch LR-Ch SC-Ch ML-Ch 50 41 37 33 29 25 20 17 14 11 7 5),
  mi:    %w(SR-P MR-Ch LL-Ch ML-Ch SR-Ch SL-Ch LC-Ch SC-Ch 50 42 37 34 29 25 22 19 16 14 10 6 4),
  si:    %w(LL-Ch SR-Ch SC-Ch MR-Ch LR-Ch ML-Ch SL-Ch 48 36 33 28 25 23 19 18 14 11 9 6 4 2),
  p:     %w(SC-Ch MR-Ch 48 31 22 20 19 18 16 14 13 12 11 9 8 6 5 4 3 1 (1)),
  ch:    %w(47 33 23 16 12 11 10 9 8 7 6 6 5 4 4 3 2 2 1 1 IN),
  sd:    %w(Sd 42 29 26 22 18 15 12 11 10 9 8 7 7 6 5 5 4 3 2 (1)),
  putt:  %w(Miss-A 1-B 2-C 3-D 3 4 4 5 6 7 8 9 10 11 12 15 18 24 40 IN IN),
}
add_clubs(player, h_clubs)


# Tournament    : year name
# Round         : number tournament_id
# PlayingAt     : seq_num hole_id name
# Group         : number round_id playing_at_id
# Grouping      : group_id player_id play_order
#
# Ball          : player_id shod_id shot_count result
# ScoreCard     : player_id round_id
# Score         : score_card_id hole_id value
