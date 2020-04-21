class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth, if: :production?
  before_action :set_category_list, only: [:index, :show,:select_category_index,:select_child_category_index,:select_grandchild_category_index]

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  # def set_mypage_menu
  #   @contents = [{name: "マイページ", path: "/users/#{current_user.id}", pattern: "GET",list_id: "my_page"},{name: "TOPへ戻る", path: "/", pattern: "GET",list_id: "to_top"},{name: "クレジットカード登録", path:new_credit_card_path, pattern: "GET",list_id: "credit_card"},{name: "ログアウト", path: "/users/sign_out", pattern: "DELETE",list_id: "logout"}]
  # end

  def set_category_list
    @category_parent_array = Category.where(ancestry: nil)
  end

  # credit_cards_controller.rbへ引っ越した
  # def set_card
  #   @card = CreditCard.find_by(user_id: current_user.id)
  # end
end
