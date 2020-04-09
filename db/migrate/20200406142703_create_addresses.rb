class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.integer :post_code,     null: false
      t.string :prefecture,     null: false
      t.string :city,           null: false
      t.string :street_number,  null: false
      t.string :building_name,  null: true
      t.references :ships,    null: false, foreign_key: true
      t.timestamps
    end
  end
end
