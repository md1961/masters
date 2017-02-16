class CreateBalls < ActiveRecord::Migration

  def change
    create_table :balls do |t|
      t.references :player, index: true, foreign_key: true
      t.references :shot  , index: true, foreign_key: true
      t.integer :shot_count, null: false, default: 0
      t.string  :result
      t.string  :lands
      t.string  :next_use
      t.boolean :is_layup   , default: false
      t.boolean :is_saved   , default: false
      t.integer :next_adjust, default: 0
      t.integer :status     , null: false, default: 0
    end
  end
end
