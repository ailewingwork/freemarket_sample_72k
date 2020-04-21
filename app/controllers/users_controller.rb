class UsersController < ApplicationController
  before_action :set_mypage_menu, only: [:show]

  def index
  end

  def new_1st_view
  end

  def show
    @user = User.find(params[:id])
  end
end
