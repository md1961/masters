class CreateGroups < ActiveRecord::Migration

  def change
    create_table :groups do |t|
      t.references :round , index: true, foreign_key: true
      t.integer    :number, null: false
    end
  end
end
