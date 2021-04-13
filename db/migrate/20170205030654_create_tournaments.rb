class CreateTournaments < ActiveRecord::Migration[4.2]

  def change
    create_table :tournaments do |t|
      t.integer :year      , null: false
      t.string  :name      , null: false, default: 'Masters'
      t.integer :num_rounds, null: false, default: 4

      t.timestamps
    end

    add_index :tournaments, :year, unique: true
  end
end
