class CreateGroupings < ActiveRecord::Migration

  def change
    create_table :groupings do |t|
      t.references :group , index: true, foreign_key: true
      t.references :player, index: true, foreign_key: true
      t.integer    :play_order
    end
  end
end
