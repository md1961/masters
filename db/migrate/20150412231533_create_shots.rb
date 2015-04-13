class CreateShots < ActiveRecord::Migration

  def change
    create_table :shots do |t|
      t.integer    :number
      t.boolean    :layup , default: false
      t.references :hole  , index: true
    end
  end
end
