class CreateShots < ActiveRecord::Migration

  def change
    create_table :shots do |t|
      t.integer    :number  , null: false
      t.boolean    :is_layup, null: false, default: false
      t.integer    :area_id , null: false, default: 0
      t.references :hole    , index: true, foreign_key: true
    end
  end
end
