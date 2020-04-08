class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :product_name,     null: false
      t.integer :price,           null: false
      t.integer :condition,       null: false
      t.text :description,        null: false
      t.integer :delivery_fee,    null: false
      t.integer :shipping_origin, null: false
      t.integer :days_to_ship,    null: false
      t.references :user,         null: false,foreign_key: { to_table: :users }
      t.references :seller,       null: false,foreign_key: { to_table: :users }
      t.references :buyer,        null: true,foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
