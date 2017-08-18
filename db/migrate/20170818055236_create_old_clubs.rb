class CreateOldClubs < ActiveRecord::Migration

  def change
    create_table :old_clubs do |t|
      t.string     :name, null: false
      t.references :player, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
