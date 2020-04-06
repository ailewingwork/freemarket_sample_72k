class AddbuyerToItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :items, :buyer, null: true,foreign_key: { to_table: :users}
  end
end
