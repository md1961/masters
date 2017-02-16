class CreateInvitations < ActiveRecord::Migration

  def change
    create_table :invitations do |t|
      t.references :tournament, index: true, foreign_key: true
      t.references :player    , index: true, foreign_key: true
    end
  end
end
