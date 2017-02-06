class CreateBalls < ActiveRecord::Migration

  def change
    create_table :balls do |t|
      t.references :player, index: true, foreign_key: true
      t.references :shot  , index: true, foreign_key: true
      t.integer :shot_count, null: false, default: 0
      t.string  :result
    end
  end
end
