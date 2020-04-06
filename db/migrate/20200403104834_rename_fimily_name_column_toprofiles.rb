class RenameFimilyNameColumnToprofiles < ActiveRecord::Migration[5.2]
  def change
    rename_column :profiles, :fimily_name, :family_name
    rename_column :profiles, :fimily_name_kana, :family_name_kana
  end
end
