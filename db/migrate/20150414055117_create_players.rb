class CreatePlayers < ActiveRecord::Migration

  def change
    create_table :players do |t|
      t.string  :last_name
      t.string  :first_name
      t.integer :overall
    end
  end
end
