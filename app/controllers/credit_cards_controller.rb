class CreditCardsController < ApplicationController
  before_action :set_mypage_menu
  before_action :set_category_list, only: [:new, :show]
  before_action :set_card, only: [:show, :destroy]

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
    unless @card.blank?
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
    redirect_to new_credit_card_path
  end

  def show #Cardのデータpayjpに送り情報を取り出す
    if @card.blank?
      redirect_to new_credit_card_path 
    else
      Payjp.api_key = Rails.application.credentials[:PAYJP_SECRET_KEY]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  private

  def set_card
    @card = CreditCard.find_by(user_id: current_user.id)
  end


  def set_mypage_menu
    @contents = [{name: "マイページ", path: "/users/#{current_user.id}", pattern: "GET",list_id: "my_page"},{name: "TOPへ戻る", path: "/", pattern: "GET",list_id: "to_top"},{name: "クレジットカード登録", path:new_credit_card_path, pattern: "GET",list_id: "credit_card"},{name: "ログアウト", path: "/users/sign_out", pattern: "DELETE",list_id: "logout"}]
  end
end
