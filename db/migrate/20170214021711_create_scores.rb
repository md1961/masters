class CreateScores < ActiveRecord::Migration[4.2]

  def change
    create_table :scores do |t|
      t.references :score_card, index: true, foreign_key: true
      t.references :hole      , index: true, foreign_key: true
      t.integer    :value
    end
  end
end
