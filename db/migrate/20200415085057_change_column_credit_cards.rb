class ChangeColumnCreditCards < ActiveRecord::Migration[5.2]
  def change
    change_column :credit_cards, :customer_id, :string, null: false
    change_column :credit_cards, :card_id, :string, null: false
  end
end
