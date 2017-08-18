class CreateOldClubResults < ActiveRecord::Migration

  def change
    create_table :old_club_results do |t|
      t.references :old_club, index: true, foreign_key: true
      t.integer    :dice  , null: false
      t.string     :result, null: false
    end
  end
end
