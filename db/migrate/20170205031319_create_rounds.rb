class CreateRounds < ActiveRecord::Migration

  def change
    create_table :rounds do |t|
      t.references :tournament, index: true, foreign_key: true
      t.integer :number     , null: false
      t.boolean :is_current , null: false, default: false
      t.integer :status     , null: false, default: 0
      t.string  :play_result
      t.string  :club_name_for_12_tee
    end

    add_index :rounds, [:tournament_id, :number], unique: true
  end
end
