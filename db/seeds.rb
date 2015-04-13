# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Hole.destroy_all
Shot.destroy_all
ShotJudge.destroy_all

hole01 = Hole.create!(number: 1, par: 4, distance: 400)
  shot01_1 = hole01.shots.create!(number: 1, layup: false)
    shot01_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot01_2 = hole01.shots.create!(number: 2, layup: false)
    shot01_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees'       , next_use: 'LI', next_adjust: -3)
    shot01_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway'     , next_use: 'LI')
    shot01_2.shot_judges.create!(prev_result: 'SR', lands: 'Trees'       , next_use: 'LI', next_adjust: -5)
    shot01_2.shot_judges.create!(prev_result: 'ML', lands: 'Trees'       , next_use: 'MI', next_adjust: -2)
    shot01_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway'     , next_use: 'MI')
    shot01_2.shot_judges.create!(prev_result: 'MR', lands: 'Fairway Trap', next_use: 'MI', next_adjust: -4)
    shot01_2.shot_judges.create!(prev_result: 'LL', lands: 'Trees'       , next_use: 'SI', next_adjust: -1)
    shot01_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway'     , next_use: 'SI')
    shot01_2.shot_judges.create!(prev_result: 'LR', lands: 'Trees'       , next_use: 'SI', next_adjust: -2)
    shot01_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees'  , next_use: 'SI', next_adjust: -8)
  shot01_3 = hole01.shots.create!(number: 3, layup: false)
    shot01_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot01_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot01_3.shot_judges.create!(prev_result: 'All P'       , lands: 'Near Green', next_use: 'P')
    shot01_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -3)
  shot01_4 = hole01.shots.create!(number: 4, layup: false)
    shot01_4.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot01_4.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot01_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole02 = Hole.create!(number: 2, par: 5, distance: 555)
  shot02_1 = hole02.shots.create!(number: 1, layup: false)
    shot02_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot02_2 = hole02.shots.create!(number: 2, layup: false)
    shot02_2.shot_judges.create!(prev_result: '(SL)', lands: 'Trees',
                                                      next_use: "{'1-3' => 'Save, LI Layup', '4-6' => 'Save, FW'}")
    shot02_2.shot_judges.create!(prev_result: 'SC',   lands: 'Fairway'       , next_use: 'FW Layup')
    shot02_2.shot_judges.create!(prev_result: 'SR',   lands: 'Fairway'       , next_use: 'FW Layup')
    shot02_2.shot_judges.create!(prev_result: '(ML)', lands: 'Trees',
                                                      next_use: "{'1-3' => 'Save, LI', '4-6' => 'Save, LI Layup'}",
                                                      next_adjust: "{'1-3' => 0, '4-6' => -1}")
    shot02_2.shot_judges.create!(prev_result: 'MC',   lands: 'Fairway', next_use: 'LI Layup')
    shot02_2.shot_judges.create!(prev_result: 'MR',   lands: 'Fairway', next_use: 'LI Layup')
    shot02_2.shot_judges.create!(prev_result: 'LL',   lands: 'Fairway', next_use: 'LI')
    shot02_2.shot_judges.create!(prev_result: 'LC',   lands: 'Fairway', next_use: 'FW')
    shot02_2.shot_judges.create!(prev_result: 'LR',   lands: 'Fairway Trap', next_use: 'LI Layup', next_adjust: -4)
    shot02_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Save. LI', next_adjust: -4)
  shot02_3 = hole02.shots.create!(number: 3, layup: true)
    shot02_3.shot_judges.create!(prev_result: '1-20'  , lands: 'Near Green', next_use: 'Ch')
    shot02_3.shot_judges.create!(prev_result: '21-40' , lands: 'Near Green', next_use: 'P', next_adjust: +2)
    shot02_3.shot_judges.create!(prev_result: '41-60' , lands: 'Near Green', next_use: 'P')
    shot02_3.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'P', next_adjust: -2)
    shot02_3.shot_judges.create!(prev_result: 'All P' , lands: 'Fairway'   , next_use: 'SI')
    shot02_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Tree'     , next_use: 'P', next_adjust: -6)

hole03 = Hole.create!(number: 3, par: 4, distance: 360)
hole04 = Hole.create!(number: 4, par: 3, distance: 205)
hole05 = Hole.create!(number: 5, par: 4, distance: 435)
hole06 = Hole.create!(number: 6, par: 3, distance: 180)
hole07 = Hole.create!(number: 7, par: 4, distance: 365)
hole08 = Hole.create!(number: 8, par: 5, distance: 535)
hole09 = Hole.create!(number: 9, par: 4, distance: 435)
hole10 = Hole.create!(number:10, par: 4, distance: 485)
hole11 = Hole.create!(number:11, par: 4, distance: 455)
hole12 = Hole.create!(number:12, par: 3, distance: 155)
hole13 = Hole.create!(number:13, par: 5, distance: 465)
hole14 = Hole.create!(number:14, par: 4, distance: 405)
hole15 = Hole.create!(number:15, par: 5, distance: 500)
hole16 = Hole.create!(number:16, par: 3, distance: 170)
hole17 = Hole.create!(number:17, par: 4, distance: 400)
hole18 = Hole.create!(number:18, par: 4, distance: 405)
