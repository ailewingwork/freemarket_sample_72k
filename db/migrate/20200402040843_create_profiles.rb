class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.text :profile,            null: true
      t.string :prof_image,       null: true
      t.string :fimily_name,      null: false
      t.string :first_name,       null: false
      t.string :fimily_name_kana, null: false
      t.string :first_name_kana,  null: false
      t.date :birth_year,         null: false
      t.date :birth_month,        null: false
      t.date :birth_day,          null: false
      t.string :mobile,           null: false
      t.references :user,         null: false, foreign_key: true
      t.timestamps
    end
  end
end
