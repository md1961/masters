class AddTypeToRound < ActiveRecord::Migration[4.2]

  def change
    add_column :rounds, :type, :string
  end
end
