class CreateClubs < ActiveRecord::Migration[4.2]

  def change
    create_table :clubs do |t|
      t.string     :name, null: false
      t.references :player, index: true, foreign_key: true
    end
  end
end
