class ChangeDataConditionToItem < ActiveRecord::Migration[5.2]
  def change
    change_column :items, :condition, :string
    change_column :items, :delivery_fee, :string
    change_column :items, :shipping_origin, :string
    change_column :items, :days_to_ship, :string
  end
end
