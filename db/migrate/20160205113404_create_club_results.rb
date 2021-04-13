class CreateClubResults < ActiveRecord::Migration[4.2]

  def change
    create_table :club_results do |t|
      t.references :club, index: true, foreign_key: true
      t.integer    :dice  , null: false
      t.string     :result, null: false
    end
  end
end
