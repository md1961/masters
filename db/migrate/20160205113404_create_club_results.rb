class CreateClubResults < ActiveRecord::Migration

  def change
    create_table :club_results do |t|
      t.references :club, index: true, foreign_key: true
      t.integer    :dice  , null: false
      t.string     :result, null: false
    end
  end
end
