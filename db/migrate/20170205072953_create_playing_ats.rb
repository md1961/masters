class CreatePlayingAts < ActiveRecord::Migration

  def change
    create_table :playing_ats do |t|
      t.references :hole, index: true
      t.integer :seq_num , null: false
      t.integer :location, null: false, default: 0
    end
  end
end
