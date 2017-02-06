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
PlayingAt.destroy_all

hole01 = Hole.create!(number: 1, par: 4, distance: 400)
  shot01_1 = hole01.shots.create!(number: 1, is_layup: false)
    shot01_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot01_2 = hole01.shots.create!(number: 2, is_layup: false)
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
  shot01_3 = hole01.shots.create!(number: 3, is_layup: false)
    shot01_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot01_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot01_3.shot_judges.create!(prev_result: 'All P'       , lands: 'Near Green', next_use: 'P')
    shot01_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -3)
  shot01_4 = hole01.shots.create!(number: 4, is_layup: false)
    shot01_4.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot01_4.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot01_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole02 = Hole.create!(number: 2, par: 5, distance: 555)
  shot02_1 = hole02.shots.create!(number: 1, is_layup: false)
    shot02_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot02_2 = hole02.shots.create!(number: 2, is_layup: false)
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
  shot02_3l = hole02.shots.create!(number: 3, is_layup: true)
    shot02_3l.shot_judges.create!(prev_result: '1-20'  , lands: 'Near Green', next_use: 'Ch')
    shot02_3l.shot_judges.create!(prev_result: '21-40' , lands: 'Near Green', next_use: 'P', next_adjust: +2)
    shot02_3l.shot_judges.create!(prev_result: '41-60' , lands: 'Near Green', next_use: 'P')
    shot02_3l.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'P', next_adjust: -2)
    shot02_3l.shot_judges.create!(prev_result: 'All P' , lands: 'Fairway'   , next_use: 'SI')
    shot02_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Tree'     , next_use: 'P', next_adjust: -6)
  shot02_3 = hole02.shots.create!(number: 3, is_layup: false)
    shot02_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot02_3.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Near Green', next_use: 'Ch')
    shot02_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'P')
    shot02_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot02_4 = hole02.shots.create!(number: 4, is_layup: false)
    shot02_4.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot02_4.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot02_4.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot02_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot02_4.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)

hole03 = Hole.create!(number: 3, par: 4, distance: 360)
  shot03_1 = hole03.shots.create!(number: 1, is_layup: false)
    shot03_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot03_2 = hole03.shots.create!(number: 2, is_layup: false)
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
  shot03_3 = hole03.shots.create!(number: 3, is_layup: false)
    shot03_3.shot_judges.create!(prev_result: 'ML-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot03_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot03_3.shot_judges.create!(prev_result: 'All P'       , lands: 'Near Green', next_use: 'P')
    shot03_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot03_4 = hole03.shots.create!(number: 4, is_layup: false)
    shot03_4.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot03_4.shot_judges.create!(prev_result: 'ML-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot03_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole04 = Hole.create!(number: 4, par: 3, distance: 205)
  shot04_1 = hole04.shots.create!(number: 1, is_layup: false)
    shot04_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'LI')
  shot04_2 = hole04.shots.create!(number: 2, is_layup: false)
    shot04_2.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_2.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_2.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'P')
    shot04_2.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot04_3 = hole04.shots.create!(number: 3, is_layup: false)
    shot04_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_3.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot04_3.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot04_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole05 = Hole.create!(number: 5, par: 4, distance: 435)
  shot05_1 = hole05.shots.create!(number: 1, is_layup: false)
    shot05_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot05_2 = hole05.shots.create!(number: 2, is_layup: false)
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
  shot05_3 = hole05.shots.create!(number: 3, is_layup: false)
    shot05_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot05_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot05_3.shot_judges.create!(prev_result: 'All P'       , lands: 'Near Green', next_use: 'P')
    shot05_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'P', next_adjust: -6)
  shot05_4 = hole05.shots.create!(number: 4, is_layup: false)
    shot05_3.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot05_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot05_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole06 = Hole.create!(number: 6, par: 3, distance: 180)
  shot06_1 = hole06.shots.create!(number: 1, is_layup: false)
    shot06_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'MI')
  shot06_2 = hole06.shots.create!(number: 2, is_layup: false)
    shot06_2.shot_judges.create!(prev_result: 'SC-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot06_2.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot06_2.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot06_2.shot_judges.create!(prev_result: 'All P'       , lands: 'Sand'      , next_use: 'Sd')
  shot06_3 = hole06.shots.create!(number: 3, is_layup: false)
    shot06_3.shot_judges.create!(prev_result: 'SC-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot06_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot06_3.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot06_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole07 = Hole.create!(number: 7, par: 4, distance: 365)
  shot07_1 = hole07.shots.create!(number: 1, is_layup: false)
    shot07_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot07_2 = hole07.shots.create!(number: 2, is_layup: false)
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
  shot07_3 = hole07.shots.create!(number: 3, is_layup: false)
    shot07_3.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_3.shot_judges.create!(prev_result: 'SC-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_3.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_3.shot_judges.create!(prev_result: 'LL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_3.shot_judges.create!(prev_result: 'LR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot07_3.shot_judges.create!(prev_result: 'All P'       , lands: 'Near Green', next_use: 'P')
    shot07_3.shot_judges.create!(prev_result: 'TROUBLE'     , lands: 'Trees'     , next_use: 'CH', next_adjust: -10)
  shot07_4 = hole07.shots.create!(number: 4, is_layup: false)
    shot07_4.shot_judges.create!(prev_result: 'SL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_4.shot_judges.create!(prev_result: 'SC-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_4.shot_judges.create!(prev_result: 'SR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_4.shot_judges.create!(prev_result: 'LL-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_4.shot_judges.create!(prev_result: 'LR-Ch'       , lands: 'Sand'      , next_use: 'Sd')
    shot07_4.shot_judges.create!(prev_result: 'Sd'          , lands: 'Sand'      , next_use: 'Sd')
    shot07_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole08 = Hole.create!(number: 8, par: 5, distance: 535)
  shot08_1 = hole08.shots.create!(number: 1, is_layup: false)
    shot08_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot08_2 = hole08.shots.create!(number: 2, is_layup: false)
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
  shot08_3l = hole08.shots.create!(number: 3, is_layup: true)
    shot08_3l.shot_judges.create!(prev_result: '1-20'  , lands: 'Near Green', next_use: 'Ch')
    shot08_3l.shot_judges.create!(prev_result: '21-40' , lands: 'Near Green', next_use: 'P')
    shot08_3l.shot_judges.create!(prev_result: '41-60' , lands: 'Near Green', next_use: 'P', next_adjust: -1)
    shot08_3l.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'P', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'SL-P'  , lands: 'Trees'     , next_use: 'SI', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'ML-P'  , lands: 'Trees'     , next_use: 'SI', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'LL-P'  , lands: 'Trees'     , next_use: 'SI', next_adjust: -2)
    shot08_3l.shot_judges.create!(prev_result: 'All other P', lands: 'Fairway', next_use: 'SI')
    shot08_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot08_3 = hole08.shots.create!(number: 3, is_layup: false)
    shot08_3.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'Ch')
    shot08_3.shot_judges.create!(prev_result: 'All P' , lands: 'Near Green', next_use: 'P')
    shot08_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot08_4 = hole08.shots.create!(number: 4, is_layup: false)
    shot08_4.shot_judges.create!(prev_result: 'All Ch' , lands: 'Near Green', next_use: 'Ch')
    shot08_4.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees'     , next_use: 'P', next_adjust: -6)

hole09 = Hole.create!(number: 9, par: 4, distance: 435)
  shot09_1 = hole09.shots.create!(number: 1, is_layup: false)
    shot09_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot09_2 = hole09.shots.create!(number: 2, is_layup: false)
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
  shot09_3 = hole09.shots.create!(number: 3, is_layup: false)
    shot09_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_3.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot09_3.shot_judges.create!(prev_result: 'All P', lands: 'Near Green', next_use: 'P')
    shot09_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Sand', next_use: 'Sd')
  shot09_4 = hole09.shots.create!(number: 4, is_layup: false)
    shot09_4.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_4.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Sand', next_use: 'Sd')
    shot09_4.shot_judges.create!(prev_result: 'Sd'   , lands: 'Sand', next_use: 'Sd')
    shot09_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole10 = Hole.create!(number:10, par: 4, distance: 485)
  shot10_1 = hole10.shots.create!(number: 1, is_layup: false)
    shot10_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot10_2 = hole10.shots.create!(number: 2, is_layup: false)
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
  shot10_3 = hole10.shots.create!(number: 3, is_layup: false)
    shot10_3.shot_judges.create!(prev_result: 'SC-P', lands: 'Sand', next_use: 'Sd')
    shot10_3.shot_judges.create!(prev_result: 'SR-P', lands: 'Sand', next_use: 'Sd')
    shot10_3.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot10_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot10_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -4)
  shot10_4 = hole10.shots.create!(number: 4, is_layup: false)
    shot10_4.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot10_4.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Sand', next_use: 'Sd')
    shot10_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole11 = Hole.create!(number:11, par: 4, distance: 455)
  shot11_1 = hole11.shots.create!(number: 1, is_layup: false)
    shot11_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot11_2 = hole11.shots.create!(number: 2, is_layup: false)
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
  shot11_3 = hole11.shots.create!(number: 3, is_layup: false)
    shot11_3.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Water', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Water', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'LC-Ch', lands: 'Sand', next_use: 'Sd')
    shot11_3.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot11_3.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot11_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot11_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Water', next_use: 'P')
  shot11_4 = hole11.shots.create!(number: 4, is_layup: false)
    shot11_4.shot_judges.create!(prev_result: 'Sd',    lands: 'Sand', next_use: 'Sd')
    shot11_4.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Water', next_use: 'P')
    shot11_4.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Water', next_use: 'P')
    shot11_4.shot_judges.create!(prev_result: 'LC-Ch', lands: 'Sand', next_use: 'Sd')
    shot11_4.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot11_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole12 = Hole.create!(number:12, par: 3, distance: 155)
  shot12_1 = hole12.shots.create!(number: 1, is_layup: false)
    shot12_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: "'1-3' => 'MI', '4-6': SI'")
  shot12_2 = hole12.shots.create!(number: 2, is_layup: false)
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
  shot12_3 = hole12.shots.create!(number: 3, is_layup: false)
    shot12_3.shot_judges.create!(prev_result: '(SL-Ch)', lands: "'1-3' => 'Water', '4-6' => 'Near Green'",
                                                         next_use: "'1-3' => 'P', '4-6' => 'Ch'")
    shot12_3.shot_judges.create!(prev_result: 'SC-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Water', next_use: 'P')
    shot12_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'LC-Ch', lands: 'Sand', next_use: 'Sd')
    shot12_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole13 = Hole.create!(number:13, par: 5, distance: 465)
  shot13_1 = hole13.shots.create!(number: 1, is_layup: false)
    shot13_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot13_2 = hole13.shots.create!(number: 2, is_layup: false)
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
  shot13_3l = hole13.shots.create!(number: 3, is_layup: true)
    shot13_3l.shot_judges.create!(prev_result: '1-30', lands: 'Near Green', next_use: 'P', next_adjust: +1)
    shot13_3l.shot_judges.create!(prev_result: '31-60', lands: 'Near Green', next_use: 'P')
    shot13_3l.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Water', next_use: 'P')
    shot13_3l.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot13_3l.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'P', next_adjust: -1)
    shot13_3l.shot_judges.create!(prev_result: 'All other P', lands: 'Fairway', next_use: 'SI')
    shot13_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Save', next_adjust: -6)
  shot13_3 = hole13.shots.create!(number: 3, is_layup: false)
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
  shot13_4 = hole13.shots.create!(number: 4, is_layup: false)
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
  shot14_1 = hole14.shots.create!(number: 1, is_layup: false)
    shot14_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot14_2 = hole14.shots.create!(number: 2, is_layup: false)
    shot14_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees', next_use: 'LI', next_adjust: -5)
    shot14_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'LI')
    shot14_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'LI')
    shot14_2.shot_judges.create!(prev_result: 'ML', lands: 'Trees', next_use: 'MI', next_adjust: -3)
    shot14_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'MI')
    shot14_2.shot_judges.create!(prev_result: 'MR', lands: 'Trees', next_use: 'MI', next_adjust: -3)
    shot14_2.shot_judges.create!(prev_result: 'LL', lands: 'Trees', next_use: 'SI', next_adjust: -2)
    shot14_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'SI')
    shot14_2.shot_judges.create!(prev_result: 'LR', lands: 'Trees', next_use: 'SI', next_adjust: -3)
    shot14_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'SI', next_adjust: -8)
  shot14_3 = hole14.shots.create!(number: 3, is_layup: false)
    shot14_3.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'Ch')
    shot14_3.shot_judges.create!(prev_result: 'All P', lands: 'Near Green', next_use: 'P')
    shot14_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot14_4 = hole14.shots.create!(number: 4, is_layup: false)
    shot14_3.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'Ch')

hole15 = Hole.create!(number:15, par: 5, distance: 500)
  shot15_1 = hole15.shots.create!(number: 1, is_layup: false)
    shot15_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot15_2 = hole15.shots.create!(number: 2, is_layup: false)
    shot15_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees', next_use: 'MI Layup', next_adjust: -1)
    shot15_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'MI Layup')
    shot15_2.shot_judges.create!(prev_result: 'SR', lands: 'Fairway', next_use: 'MI Layup')
    shot15_2.shot_judges.create!(prev_result: 'ML', lands: 'Trees', next_use: 'SI Layup or FW', next_adjust: -1)
    shot15_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'SI Layup or FW')
    shot15_2.shot_judges.create!(prev_result: 'MR', lands: 'Mounds', next_use: 'SI Layup or FW(-1)')
    shot15_2.shot_judges.create!(prev_result: 'LL', lands: 'Trees', next_use: 'SI Layup or LI(-2)')
    shot15_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'SI Layup(+1) or LI')
    shot15_2.shot_judges.create!(prev_result: 'LR', lands: 'Mounds', next_use: 'SI Layup(+1) or LI')
    shot15_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'Save, LI')
  shot15_3l = hole15.shots.create!(number: 3, is_layup: true)
    shot15_3l.shot_judges.create!(prev_result: '1-30', lands: 'Near Green', next_use: 'P', next_adjust: +1)
    shot15_3l.shot_judges.create!(prev_result: '31-60', lands: 'Near Green', next_use: 'P')
    shot15_3l.shot_judges.create!(prev_result: 'All Ch', lands: 'Near Green', next_use: 'P', next_adjust: -1)
    shot15_3l.shot_judges.create!(prev_result: 'All P', lands: 'Near Green', next_use: 'SI')
    shot15_3l.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot15_3 = hole15.shots.create!(number: 3, is_layup: false)
    shot15_3.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'P')
    shot15_3.shot_judges.create!(prev_result: 'SC-P', lands: 'Water', next_use: 'P')
    shot15_3.shot_judges.create!(prev_result: 'SR-P', lands: 'Water', next_use: 'P')
    shot15_3.shot_judges.create!(prev_result: 'MR-Ch', lands: 'Sand', next_use: 'Sd')
    shot15_3.shot_judges.create!(prev_result: '(SL-Ch)', lands: "'1-2' => 'Water', '3-6'=> 'Near Green'",
                                                         next_use: "'1-2' => 'P', '3-6' => 'Ch'")
    shot15_3.shot_judges.create!(prev_result: '(SC-Ch)', lands: "'1-2' => 'Water', '3-6'=> 'Near Green'",
                                                         next_use: "'1-2' => 'P', '3-6' => 'Ch'")
    shot15_3.shot_judges.create!(prev_result: '(SR-Ch)', lands: "'1-2' => 'Water', '3-6'=> 'Near Green'",
                                                         next_use: "'1-2' => 'P', '3-6' => 'Ch'")
    shot15_3.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot15_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot15_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot15_4 = hole15.shots.create!(number: 4, is_layup: false)
    shot15_4.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot15_4.shot_judges.create!(prev_result: '(SL-Ch)', lands: "'1-2' => 'Water', '3-6'=> 'Near Green'",
                                                         next_use: "'1-2' => 'P', '3-6' => 'Ch'")
    shot15_4.shot_judges.create!(prev_result: '(SC-Ch)', lands: "'1-2' => 'Water', '3-6'=> 'Near Green'",
                                                         next_use: "'1-2' => 'P', '3-6' => 'Ch'")
    shot15_4.shot_judges.create!(prev_result: '(SR-Ch)', lands: "'1-2' => 'Water', '3-6'=> 'Near Green'",
                                                         next_use: "'1-2' => 'P', '3-6' => 'Ch'")
    shot15_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot15_4.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)

hole16 = Hole.create!(number:16, par: 3, distance: 170)
  shot16_1 = hole16.shots.create!(number: 1, is_layup: false)
    shot16_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'MI')
  shot16_2 = hole16.shots.create!(number: 2, is_layup: false)
    shot16_2.shot_judges.create!(prev_result: 'SL-P', lands: 'Water', next_use: 'SI')
    shot16_2.shot_judges.create!(prev_result: 'SC-P', lands: 'Water', next_use: 'SI')
    shot16_2.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Sand', next_use: 'Sd')
    shot16_2.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot16_2.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot16_2.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Water', next_use: 'SI')
    shot16_2.shot_judges.create!(prev_result: '(ML-Ch)', lands: "'1-3' => 'Water', '4-6' => 'Near Green'",
                                                         next_use: "'1-3' => 'SI', '4-6' => 'Ch'")
    shot16_2.shot_judges.create!(prev_result: 'All other P', lands: 'Near Green', next_use: 'P')
    shot16_2.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot16_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)
  shot16_3 = hole16.shots.create!(number: 3, is_layup: false)
    shot16_3.shot_judges.create!(prev_result: 'Sd', lands: 'Sand', next_use: 'Sd')
    shot16_3.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Sand', next_use: 'Sd')
    shot16_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Sand', next_use: 'Sd')
    shot16_3.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Sand', next_use: 'Sd')
    shot16_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Water', next_use: 'P')
    shot16_3.shot_judges.create!(prev_result: '(ML-Ch)', lands: "'1-3' => 'Water', '4-6' => 'Near Green'",
                                                         next_use: "'1-3' => 'P', '4-6' => 'Ch'")
    shot16_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot16_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'P', next_adjust: -6)

hole17 = Hole.create!(number:17, par: 4, distance: 400)
  shot17_1 = hole17.shots.create!(number: 1, is_layup: false)
    shot17_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot17_2 = hole17.shots.create!(number: 2, is_layup: false)
    shot17_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees', next_use: 'LI', next_adjust: -5)
    shot17_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'LI')
    shot17_2.shot_judges.create!(prev_result: 'SR', lands: 'Trees', next_use: 'LI', next_adjust: -4)
    shot17_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway', next_use: 'MI')
    shot17_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'MI')
    shot17_2.shot_judges.create!(prev_result: 'MR', lands: 'Trees', next_use: 'MI', next_adjust: -1)
    shot17_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway', next_use: 'SI')
    shot17_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'SI')
    shot17_2.shot_judges.create!(prev_result: 'LR', lands: 'Fairway', next_use: 'SI')
    shot17_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Mounds', next_use: 'SI', next_adjust: -3)
  shot17_3 = hole17.shots.create!(number: 3, is_layup: false)
    shot17_3.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Sand' , next_use: 'Sd')
    shot17_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand' , next_use: 'Sd')
    shot17_3.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Rocks', next_use: 'Ch', next_adjust: -1)
    shot17_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot17_3.shot_judges.create!(prev_result: 'All other P' , lands: 'Near Green', next_use: 'P')
    shot17_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Sand', next_use: 'Sd')
  shot17_4 = hole17.shots.create!(number: 4, is_layup: false)
    shot17_4.shot_judges.create!(prev_result: 'SR-Ch', lands: 'Sand' , next_use: 'Sd')
    shot17_4.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand' , next_use: 'Sd')
    shot17_4.shot_judges.create!(prev_result: 'LR-Ch', lands: 'Rocks', next_use: 'Ch', next_adjust: -1)
    shot17_4.shot_judges.create!(prev_result: 'Sd'   , lands: 'Sand' , next_use: 'Sd')
    shot17_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')

hole18 = Hole.create!(number:18, par: 4, distance: 405)
  shot18_1 = hole18.shots.create!(number: 1, is_layup: false)
    shot18_1.shot_judges.create!(prev_result: nil, lands: nil, next_use: 'Drive')
  shot18_2 = hole18.shots.create!(number: 2, is_layup: false)
    shot18_2.shot_judges.create!(prev_result: 'SL', lands: 'Trees', next_use: 'LI', next_adjust: -2)
    shot18_2.shot_judges.create!(prev_result: 'SC', lands: 'Fairway', next_use: 'LI')
    shot18_2.shot_judges.create!(prev_result: '(SR)', lands: 'Trees',
                                                    next_use: "'1-2' => 'Save, SI', '3-4' => 'Sand, P', '5-6' => 'LI'",
                                                    next_adjust: "'1-4' => 0, '5-6' => -5")
    shot18_2.shot_judges.create!(prev_result: 'ML', lands: 'Fairway Trap', next_use: 'MI', next_adjust: -3)
    shot18_2.shot_judges.create!(prev_result: 'MC', lands: 'Fairway', next_use: 'MI')
    shot18_2.shot_judges.create!(prev_result: 'MR', lands: 'Trees', next_use: 'MI', next_adjust: -3)
    shot18_2.shot_judges.create!(prev_result: 'LL', lands: 'Fairway Trap', next_use: 'SI', next_adjust: -5)
    shot18_2.shot_judges.create!(prev_result: 'LC', lands: 'Fairway', next_use: 'SI')
    shot18_2.shot_judges.create!(prev_result: 'LR', lands: 'Trees', next_use: 'SI', next_adjust: -3)
    shot18_2.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Trees', next_use: 'SI', next_adjust: -6)
  shot18_3 = hole18.shots.create!(number: 3, is_layup: false)
    shot18_3.shot_judges.create!(prev_result: 'SL-P' , lands: 'Rough', next_use: 'P', next_adjust: -1)
    shot18_3.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand' , next_use: 'Sd')
    shot18_3.shot_judges.create!(prev_result: 'MR-Ch', lands: 'Sand' , next_use: 'Sd')
    shot18_3.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Rough', next_use: 'Ch', next_adjust: -2)
    shot18_3.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Rough', next_use: 'Ch', next_adjust: -2)
    shot18_3.shot_judges.create!(prev_result: 'All other P' , lands: 'Near Green', next_use: 'P')
    shot18_3.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')
    shot18_3.shot_judges.create!(prev_result: 'TROUBLE', lands: 'Sand', next_use: 'Sd')
  shot18_4 = hole18.shots.create!(number: 4, is_layup: false)
    shot18_4.shot_judges.create!(prev_result: 'Sd'   , lands: 'Sand' , next_use: 'Sd')
    shot18_4.shot_judges.create!(prev_result: 'SL-Ch', lands: 'Sand' , next_use: 'Sd')
    shot18_4.shot_judges.create!(prev_result: 'MR-Ch', lands: 'Sand' , next_use: 'Sd')
    shot18_4.shot_judges.create!(prev_result: 'ML-Ch', lands: 'Rough', next_use: 'Ch', next_adjust: -2)
    shot18_4.shot_judges.create!(prev_result: 'LL-Ch', lands: 'Rough', next_use: 'Ch', next_adjust: -2)
    shot18_4.shot_judges.create!(prev_result: 'All other Ch', lands: 'Near Green', next_use: 'Ch')


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
    raise StandardError, "illeagl size #{results.size} for #{name} of #{player.last_name}, #{player.first_name}" \
      unless results.size == 21
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
  mi:    %w(SC-P ML-Ch SR-Ch LL-Ch SC-SC LC-Ch MR-Ch 56 44 39 35 32 27 24 20 18 16 13 9 6 3),
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
# Ball          : player_id lands next_use next_adjust shot_count
# ScoreCard     : player_id round_id
# Score         : score_card_id hole_id value
