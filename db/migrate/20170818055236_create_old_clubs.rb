class CreateOldClubs < ActiveRecord::Migration[4.2]

  def change
    create_table :old_clubs do |t|
      t.string     :name, null: false
      t.references :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
