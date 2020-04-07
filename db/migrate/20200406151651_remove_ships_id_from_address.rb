class RemoveShipsIdFromAddress < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :addresses, :ships
    remove_reference :addresses, :ships, index: true
  end
end
