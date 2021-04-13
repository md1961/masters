class CreateHoles < ActiveRecord::Migration[4.2]

  def change
    create_table :holes do |t|
      t.integer :number  , null: false
      t.integer :par     , null: false
      t.integer :distance, null: false
    end
  end
end
