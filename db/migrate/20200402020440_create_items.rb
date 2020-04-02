class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :product_name, null: false
      t.integer :price, null: false
      t.integer :condition, null: false
      t.text :description, null: false, limit: 1000
      t.integer :delivery_fee,null: false
      t.integer :shipping_origin, null: false
      t.integer :days_to_ship, null: false


      t.timestamps
    end
  end
end
