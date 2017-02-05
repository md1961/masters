class CreateRounds < ActiveRecord::Migration

  def change
    create_table :rounds do |t|
      t.references :tournament, index: true, foreign_key: true
      t.integer :number, null: false
    end

    add_index :rounds, [:tournament_id, :number], unique: true
  end
end
