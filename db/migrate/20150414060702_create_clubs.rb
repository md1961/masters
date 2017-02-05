class CreateClubs < ActiveRecord::Migration

  KEYS = %w(11 12 13 14 15 16 22 23 24 25 26 33 34 35 36 44 45 46 55 56 66)

  def change
    create_table :clubs do |t|
      t.string     :name, null: false
      t.references :player, index: true, foreign_key: true
      KEYS.each do |key|
        t.string :"d#{key}", null: false
      end
    end
  end
end
