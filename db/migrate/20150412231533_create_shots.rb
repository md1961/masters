class CreateShots < ActiveRecord::Migration

  def change
    create_table :shots do |t|
      t.integer    :number   , null: false
      t.boolean    :is_layup , null: false, default: false
      t.references :hole     , index: true
    end
  end
end
