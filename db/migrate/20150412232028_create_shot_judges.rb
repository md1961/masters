class CreateShotJudges < ActiveRecord::Migration

  def change
    create_table :shot_judges do |t|
      t.string     :prev_result, default: nil
      t.string     :lands      , default: nil
      t.string     :next_use
      t.integer    :next_adjust, default: 0
      t.references :shot       , index: true
    end
  end
end
