class CreateRounds < ActiveRecord::Migration

  def change
    create_table :rounds do |t|
      t.references :tournament, index: true, foreign_key: true
      t.integer :number       , null: false
      t.boolean :is_current   , null: false, default: false
      t.boolean :ready_to_play, null: false, default: false
      t.string  :play_result
    end

    add_index :rounds, [:tournament_id, :number], unique: true
  end
end
