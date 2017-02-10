class CreateAreas < ActiveRecord::Migration

  def change
    create_table :areas do |t|
      t.references :round, index: true, foreign_key: true
      t.integer :seq_num , null: false
      t.integer :name    , null: false, default: 0
    end
  end
end
