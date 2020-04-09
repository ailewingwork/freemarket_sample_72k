class UsersController < ApplicationController

  def index
  end

  def new_1st_view
  end

  def show
    # @user = User.find(params[:id])
    @contents = [{name: "クレジットカード登録", path:"#", pattern: "GET",list_id: "credit_card"},{name: "ログアウト", path: "/users/sign_out", pattern: "DELETE",list_id: "logout"}]
  end

  def logout
    binding.pry
  end
end


