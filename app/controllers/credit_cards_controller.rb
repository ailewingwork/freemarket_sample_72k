class CreditCardsController < ApplicationController

  def new
    card = CreditCard.where(user_id: current_user.id)
    redirect_to credit_card_path(current_user.id) if card.exists?
  end
  
  def pay #payjpとCreditCardのデータベース作成
    Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
    #保管した顧客IDでpayjpから情報取得
    if params['payjp-token'].blank?
      redirect_to new_creditcard_path
    else
      customer = Payjp::Customer.create(
        card: params['payjp-token'],
        metadata: {user_id: current_user.id}
      ) 
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to credit_card_path(current_user.id)
      else
        redirect_to pay_creditcards_path
      end
    end
  end

  def destroy #PayjpとCardデータベースを削除
    card = CreditCard.find_by(user_id: current_user.id)
    unless card.blank?
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
    redirect_to new_credit_card_path
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    card = CreditCard.find_by(user_id: current_user.id)
    if card.blank?
      redirect_to new_credit_card_path 
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(card.customer_id)
      @default_card_information = customer.cards.retrieve(card.card_id)
    end
  end
end