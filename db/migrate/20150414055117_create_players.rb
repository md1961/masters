class CreatePlayers < ActiveRecord::Migration[4.2]

  def change
    create_table :players do |t|
      t.string  :last_name , null: false
      t.string  :first_name, null: false
      t.integer :overall   , null: false
    end
  end
end
