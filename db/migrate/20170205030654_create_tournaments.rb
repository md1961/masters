class CreateTournaments < ActiveRecord::Migration

  def change
    create_table :tournaments do |t|
      t.integer :year, null: false
      t.string  :name, null: false, default: 'Masters'

      t.timestamps
    end

    add_index :tournaments, :year, unique: true
  end
end
