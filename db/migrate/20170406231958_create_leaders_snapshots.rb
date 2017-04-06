class CreateLeadersSnapshots < ActiveRecord::Migration

  def change
    create_table :leaders_snapshots do |t|
      t.references :round, index: true, foreign_key: true
      t.integer    :seq_num

      t.timestamps null: false
    end
  end
end
