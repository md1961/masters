class CreateScoreCards < ActiveRecord::Migration

  def change
    create_table :score_cards do |t|
      t.references :player, index: true, foreign_key: true
      t.references :round , index: true, foreign_key: true
    end
  end
end
