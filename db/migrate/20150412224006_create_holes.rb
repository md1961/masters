class CreateHoles < ActiveRecord::Migration

  def change
    create_table :holes do |t|
      t.integer :number  , null: false
      t.integer :par     , null: false
      t.integer :distance, null: false
    end
  end
end
