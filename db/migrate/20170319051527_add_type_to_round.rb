class AddTypeToRound < ActiveRecord::Migration

  def change
    add_column :rounds, :type, :string
  end
end
