class CreateShotJudges < ActiveRecord::Migration[4.2]

  def change
    create_table :shot_judges do |t|
      t.string     :prev_result, default: nil
      t.string     :lands      , default: nil
      t.string     :next_use
      t.integer    :next_adjust, default: 0
      t.references :shot       , index: true, foreign_key: true
    end
  end
end
