class RenameConditionColumnToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :condition, :condition_id
  end
end
