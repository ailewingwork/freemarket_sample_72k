class RenameDeliveryFeeColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :delivery_fee, :delivery_fee_id
  end
end
