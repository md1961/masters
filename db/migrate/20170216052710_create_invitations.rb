class CreateInvitations < ActiveRecord::Migration

  def change
    create_table :invitations do |t|
      t.references :tournament, index: true, foreign_key: true
      t.references :player    , index: true, foreign_key: true
      t.integer :cut_after_round_number_of
    end
  end
end
