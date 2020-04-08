class CreateShips < ActiveRecord::Migration[5.2]
  def change
    create_table :ships do |t|
      t.string          :shipping_family_name
      t.string          :shipping_first_name
      t.string          :shipping_family_name_kana
      t.string          :shipping_first_name_kana
      t.string          :mobile, null: true
      t.references      :user
      t.timestamps
    end
  end
end
