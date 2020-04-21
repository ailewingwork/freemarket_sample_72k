class RenameDeliveryDaysToShipColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :days_to_ship, :days_to_ship_id
  end
end
