class AddReferencesToAddress < ActiveRecord::Migration[5.2]
  def change
    add_reference :addresses, :ship, null: false, foreign_key: true
  end
end
