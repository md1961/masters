class CreatePlayingAts < ActiveRecord::Migration

  def change
    create_table :playing_ats do |t|
      t.references :tournament, index: true, foreign_key: true
      t.references :hole      , index: true, foreign_key: true
      t.integer :seq_num , null: false
      t.integer :location, null: false, default: 0
    end
  end
end
