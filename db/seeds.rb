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
  shot02_3l = hole02.shots.create!(number: 3, layup: true)
    shot02_3l.shot_judges.create!(prev_result: '1-20'  , lands: 'Near Green', next_use: 'Ch')
    shot02_3l.shot_judges.create!(prev_result: '21-40' , lands: 'Near Green', next_use: 'P', next_adjust: +2)
    shot02_3l.shot_judges.create!(prev_result: '41-60' , lands: 'Near Green', next_use: 'P')
    shot02_3l.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'P', next_adjust: -2)
    shot02_3l.shot_judges.create!(prev_result: 'All P' , lands: 'Fairway'   , next_use: 'SI')
    shot02_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Tree'     , next_use: 'P', next_adjust: -6)
  shot02_3 = hole02.shots.create!(number: 3, layup: false)
    shot02_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot02_3.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Near Green', next_use: 'Ch')
    shot02_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'P')
    shot02_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot02_4 = hole02.shots.create!(number: 4, layup: false)
    shot02_4.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot02_4.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot02_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot02_4.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)

hole03 = Hole.create!(number: 3, par: 4, distance: 360)
  shot03_1 = hole03.shots.create!(number: 1, layup: false)
    shot03_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot03_2 = hole03.shots.create!(number: 2, layup: false)
    shot03_2.shot_judges.create!(prev_result: 'SL', lands: 'Fairway', next_use: 'MI')
    shot03_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'MI')
    shot03_2.shot_judges.create!(prev_result: 'SR', lands: 'Trees'  , next_use: 'MI', next_adjust: -2)
    shot03_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway Trap', next_use: 'SI', next_adjust: -4)
    shot03_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway'     , next_use: 'SI')
    shot03_2.shot_judges.create!(prev_result: 'MR', lands: 'Trees'       , next_use: 'SI', next_adjust: -2)
    shot03_2.shot_judges.create!(prev_result: 'LL', lands: 'Near Green'  , next_use: 'P')
    shot03_2.shot_judges.create!(prev_result: 'LC', lands: 'Near Green'  , next_use: 'P')
    shot03_2.shot_judges.create!(prev_result: 'LR', lands: 'Trees'       , next_use: 'P', next_adjust: -2)
    shot03_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees'  , next_use: 'P', next_adjust: -4)

hole04 = Hole.create!(number: 4, par: 3, distance: 205)
  shot04_1 = hole04.shots.create!(number: 1, layup: false)
    shot04_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'LI')
  shot04_2 = hole04.shots.create!(number: 2, layup: false)
    shot04_2.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_2.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_2.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'P')
    shot04_2.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot04_3 = hole04.shots.create!(number: 3, layup: false)
    shot04_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_3.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole05 = Hole.create!(number: 5, par: 4, distance: 435)
  shot05_1 = hole05.shots.create!(number: 1, layup: false)
    shot05_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot05_2 = hole05.shots.create!(number: 2, layup: false)
    shot05_2.shot_judges.create!(prev_result: '(SL)', lands: 'Trees',
                                                      next_use: "'1-3' => 'Save, LI', '4-5' => 'Save, MI', '6' -> 'Save, SI'")
    shot05_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'FW')
    shot05_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'FW')
    shot05_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway Trap', next_use: 'LI', next_adjust: -5)
    shot05_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway'     , next_use: 'LI')
    shot05_2.shot_judges.create!(prev_result: 'MR', lands: 'Trees'       , next_use: 'LI', next_adjust: -2)
    shot05_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'MI', next_adjust: -1)
    shot05_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'MI')
    shot05_2.shot_judges.create!(prev_result: 'LR', lands: 'Trees'  , next_use: 'MI', next_adjust: -8)
  shot05_3 = hole05.shots.create!(number: 3, layup: false)
    shot05_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot05_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot05_3.shot_judges.create!(prev_result: 'All P'       , lands: 'Near Green', next_use: 'P')
    shot05_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot05_4 = hole05.shots.create!(number: 4, layup: false)
    shot05_3.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot05_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot05_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole06 = Hole.create!(number: 6, par: 3, distance: 180)
  shot06_1 = hole06.shots.create!(number: 1, layup: false)
    shot06_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'MI')
  shot06_2 = hole06.shots.create!(number: 2, layup: false)
    shot06_2.shot_judges.create!(prev_result: 'SC-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot06_2.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot06_2.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot06_2.shot_judges.create!(prev_result: 'All P'       , lands: 'Sand'      , next_use: 'Sd')

hole07 = Hole.create!(number: 7, par: 4, distance: 365)
  shot07_1 = hole07.shots.create!(number: 1, layup: false)
    shot07_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot07_2 = hole07.shots.create!(number: 2, layup: false)
    shot07_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees'  , next_use: 'MI', next_adjust: -4)
    shot07_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'MI')
    shot07_2.shot_judges.create!(prev_result: 'SR', lands: 'Trees'  , next_use: 'MI', next_adjust: -4)
    shot07_2.shot_judges.create!(prev_result: 'ML', lands: 'Trees'  , next_use: 'SI', next_adjust: -4)
    shot07_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'SI')
    shot07_2.shot_judges.create!(prev_result: 'MR', lands: 'Trees'  , next_use: 'SI', next_adjust: -4)
    shot07_2.shot_judges.create!(prev_result: 'LL', lands: 'Trees'  , next_use: 'P', next_adjust: -3)
    shot07_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'P')
    shot07_2.shot_judges.create!(prev_result: 'LR', lands: 'Trees'  , next_use: 'P', next_adjust: -3)
    shot07_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -8)

hole08 = Hole.create!(number: 8, par: 5, distance: 535)
  shot08_1 = hole08.shots.create!(number: 1, layup: false)
    shot08_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot08_2 = hole08.shots.create!(number: 2, layup: false)
    shot08_2.shot_judges.create!(prev_result: 'SL', lands: 'Fairway', next_use: 'FW Layup', next_adjust: -3)
    shot08_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'FW Layup', next_adjust: -3)
    shot08_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'FW Layup', next_adjust: -3)
    shot08_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway'     , next_use: 'FW Layup')
    shot08_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway'     , next_use: 'FW Layup')
    shot08_2.shot_judges.create!(prev_result: 'MR', lands: 'Fairway Trap', next_use: 'LI Layup', next_adjust: -4)
    shot08_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'FW')
    shot08_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'FW')
    shot08_2.shot_judges.create!(prev_result: 'LR', lands: 'Fairway', next_use: 'FW')
    shot08_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Save, FW')
  shot08_3l = hole08.shots.create!(number: 3, layup: true)
    shot08_3l.shot_judges.create!(prev_result: '1-20'  , lands: 'Near Green', next_use: 'Ch')
    shot08_3l.shot_judges.create!(prev_result: '21-40' , lands: 'Near Green', next_use: 'P')
    shot08_3l.shot_judges.create!(prev_result: '41-60' , lands: 'Near Green', next_use: 'P', next_adjust: -1)
    shot08_3l.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'P', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'SL-P'  , lands: 'Trees'     , next_use: 'SI', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'ML-P'  , lands: 'Trees'     , next_use: 'SI', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'LL-P'  , lands: 'Trees'     , next_use: 'SI', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'All other P', lands: 'Fairway', next_use: 'SI')
    shot08_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot08_3 = hole08.shots.create!(number: 3, layup: false)
    shot08_3.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'Ch')
    shot08_3.shot_judges.create!(prev_result: 'All P' , lands: 'Near Green', next_use: 'P')
    shot08_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot08_4 = hole08.shots.create!(number: 4, layup: false)
    shot08_4.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'Ch')
    shot08_4.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)

hole09 = Hole.create!(number: 9, par: 4, distance: 435)
  shot09_1 = hole09.shots.create!(number: 1, layup: false)
    shot09_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot09_2 = hole09.shots.create!(number: 2, layup: false)
    shot09_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees'  , next_use: 'LI', next_adjust: -5)
    shot09_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'LI')
    shot09_2.shot_judges.create!(prev_result: 'SR', lands: 'Trees'  , next_use: 'LI', next_adjust: -4)
    shot09_2.shot_judges.create!(prev_result: 'ML', lands: 'Trees'  , next_use: 'MI', next_adjust: -3)
    shot09_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'MI')
    shot09_2.shot_judges.create!(prev_result: 'MR', lands: 'Fairway', next_use: 'MI')
    shot09_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'SI')
    shot09_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'SI')
    shot09_2.shot_judges.create!(prev_result: 'LR', lands: 'Fairway', next_use: 'SI')
    shot09_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Rough', next_use: 'SI', next_adjust: -6)
  shot09_3 = hole09.shots.create!(number: 3, layup: false)
    shot09_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_3.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot09_3.shot_judges.create!(prev_result: 'All P', lands: 'Near Green', next_use: 'P')
    shot09_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Sand', next_use: 'Sd')
  shot09_4 = hole09.shots.create!(number: 4, layup: false)
    shot09_4.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot09_4.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_4.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole10 = Hole.create!(number:10, par: 4, distance: 485)
  shot10_1 = hole10.shots.create!(number: 1, layup: false)
    shot10_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot10_2 = hole10.shots.create!(number: 2, layup: false)
    shot10_2.shot_judges.create!(prev_result: 'SL', lands: 'Fairway', next_use: 'FW')
    shot10_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'FW')
    shot10_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'FW')
    shot10_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway', next_use: 'LI')
    shot10_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'LI')
    shot10_2.shot_judges.create!(prev_result: 'MR', lands: 'Fairway', next_use: 'LI')
    shot10_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'MI')
    shot10_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'MI')
    shot10_2.shot_judges.create!(prev_result: 'LR', lands: 'Fairway', next_use: 'MI')
    shot10_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'MI', next_adjust: -6)
  shot10_3 = hole10.shots.create!(number: 3, layup: false)
    shot10_3.shot_judges.create!(prev_result: 'SC-P', lands: 'Sand', next_use: 'Sd')
    shot10_3.shot_judges.create!(prev_result: 'SR-P', lands: 'Sand', next_use: 'Sd')
    shot10_3.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot10_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot10_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -4)
  shot10_4 = hole10.shots.create!(number: 4, layup: false)
    shot10_4.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot10_4.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Sand', next_use: 'Sd')
    shot10_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole11 = Hole.create!(number:11, par: 4, distance: 455)
  shot11_1 = hole11.shots.create!(number: 1, layup: false)
    shot11_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot11_2 = hole11.shots.create!(number: 2, layup: false)
    shot11_2.shot_judges.create!(prev_result: 'SL', lands: 'Fairway', next_use: 'FW')
    shot11_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'FW')
    shot11_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'FW')
    shot11_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway', next_use: 'LI')
    shot11_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'LI')
    shot11_2.shot_judges.create!(prev_result: 'MR', lands: 'Fairway', next_use: 'LI')
    shot11_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'MI')
    shot11_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'MI')
    shot11_2.shot_judges.create!(prev_result: 'LR', lands: 'Fairway', next_use: 'MI')
    shot11_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'MI', next_adjust: -4)
  shot11_3 = hole11.shots.create!(number: 3, layup: false)
    shot11_3.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Water', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Water', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'LC-Ch', lands: 'Sand', next_use: 'Sd')
    shot11_3.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot11_3.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot11_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Water', next_use: 'P')

hole12 = Hole.create!(number:12, par: 3, distance: 155)
  shot12_1 = hole12.shots.create!(number: 1, layup: false)
    shot12_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: "'1-3' => 'MI', '4-6': SI'")
  shot12_2 = hole12.shots.create!(number: 2, layup: false)
    shot12_2.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot12_2.shot_judges.create!(prev_result: 'SC-P', lands: 'Water', next_use: 'P')
    shot12_2.shot_judges.create!(prev_result: 'SR-P', lands: 'Water', next_use: 'P')
    shot12_2.shot_judges.create!(prev_result: '(SL-Ch)', lands: "'1-3' => 'Water', '4-6' => 'Near Green'", next_use: 'Ch')
    shot12_2.shot_judges.create!(prev_result: 'SC-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_2.shot_judges.create!(prev_result: '(SR-Ch)', lands: "'1-2' => 'Water', '3-6' => 'Penalty'",
                                                         next_use: 'P', next_adjust: "'1-2' => -5, '3-6' => 0")
    shot12_2.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot12_2.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot12_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Ch', next_adjust: -6)
  shot12_3 = hole12.shots.create!(number: 3, layup: false)
    shot12_3.shot_judges.create!(prev_result: '(SL-Ch)', lands: "'1-3' => 'Water', '4-6' => 'Near Green'",
                                                         next_use: "'1-3' => 'P', '4-6' => 'Ch'")
    shot12_3.shot_judges.create!(prev_result: 'SC-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Water', next_use: 'P')
    shot12_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'LC-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole13 = Hole.create!(number:13, par: 5, distance: 465)
  shot13_1 = hole13.shots.create!(number: 1, layup: false)
    shot13_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot13_2 = hole13.shots.create!(number: 2, layup: false)
    shot13_2.shot_judges.create!(prev_result: 'SL', lands: 'Water', next_use: 'LI Layup')
    shot13_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'MI Layup')
    shot13_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'MI Layup')
    shot13_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway', next_use: 'SI Layup or FW')
    shot13_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'SI Layup or FW')
    shot13_2.shot_judges.create!(prev_result: 'MR', lands: 'Fairway', next_use: 'SI Layup')
    shot13_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'SI Layup (+1) or LI')
    shot13_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'SI Layup (+1) or LI')
    shot13_2.shot_judges.create!(prev_result: 'LR', lands: 'Fairway', next_use: 'SI Layup (+1) or LI (-2)')
    shot13_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Save', next_adjust: -4)
  shot13_3l = hole13.shots.create!(number: 3, layup: true)
    shot13_3l.shot_judges.create!(prev_result: '1-30', lands: 'Near Green', next_use: 'P', next_adjust: +1)
    shot13_3l.shot_judges.create!(prev_result: '31-60', lands: 'Near Green', next_use: 'P')
    shot13_3l.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Water', next_use: 'P')
    shot13_3l.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot13_3l.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'P', next_adjust: -1)
    shot13_3l.shot_judges.create!(prev_result: 'All other P', lands: 'Fairway', next_use: 'SI')
    shot13_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Save', next_adjust: -6)
  shot13_3 = hole13.shots.create!(number: 3, layup: false)
    shot13_3.shot_judges.create!(prev_result: '1-30', lands: 'Near Green', next_use: 'P', next_adjust: +1)
    shot13_3.shot_judges.create!(prev_result: 'SC-P', lands: 'Water', next_use: 'P')
    shot13_3.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot13_3.shot_judges.create!(prev_result: 'SR-P', lands: 'Water', next_use: 'P')
    shot13_3.shot_judges.create!(prev_result: '(SC-Ch)', lands: "'1-2' => 'Water', '3-6' => 'Penalty'",
                                                         next_use: 'P', next_adjust: "'1-2' => -5, '3-6' => 0")
    shot13_3.shot_judges.create!(prev_result: '(SR-Ch)', lands: "'1-2' => 'Water', '3-6' => 'Penalty'",
                                                         next_use: 'P', next_adjust: "'1-2' => -5, '3-6' => 0")
    shot13_3.shot_judges.create!(prev_result: '(SL-Ch)', lands: "'1-2' => 'Water', '3-6' => 'Penalty'",
                                                         next_use: 'P', next_adjust: "'1-2' => -5, '3-6' => 0")
    shot13_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot13_3.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot13_3.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Sand', next_use: 'Sd')
    shot13_3.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot13_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot13_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot13_4 = hole13.shots.create!(number: 3, layup: false)
    shot13_4.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot13_4.shot_judges.create!(prev_result: 'SC-Ch', lands: 'Water', next_use: 'P')
    shot13_4.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Water', next_use: 'P')
    shot13_4.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Water', next_use: 'P')
    shot13_4.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot13_4.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot13_4.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Sand', next_use: 'Sd')
    shot13_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot13_4.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)

hole14 = Hole.create!(number:14, par: 4, distance: 405)
hole15 = Hole.create!(number:15, par: 5, distance: 500)
hole16 = Hole.create!(number:16, par: 3, distance: 170)
hole17 = Hole.create!(number:17, par: 4, distance: 400)
hole18 = Hole.create!(number:18, par: 4, distance: 405)
