class CreateLeaders < ActiveRecord::Migration[4.2]

  def change
    create_table :leaders do |t|
      t.references :leaders_snapshot, index: true, foreign_key: true
      t.references :player          , index: true, foreign_key: true
      t.integer :rank
      t.integer :score
      t.string  :hole_finished
    end
  end
end
