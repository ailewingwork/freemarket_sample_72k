# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
  end

  # POST /resource
  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @profile = @user.build_profile
    render :new_profile
  end

  def create_profile
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(profile_params)
    unless @profile.valid?
      flash.now[:alert] = @profile.errors.full_messages
      render :new_profile and return
    end
    @user.build_profile(@profile.attributes)
    session["profile"] = @profile.attributes
    @ship = @user.build_ship
    render :new_ship
  end


  def create_ship
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["profile"])
    @ship = Ship.new(ship_params)
    unless @ship.valid?
      flash.now[:alert] = @ship.errors.full_messages
      render :new_ship and return
    end
    session["ship"] = @ship.attributes
    @address = @ship.build_address
    render :new_address
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @profile = Profile.new(session["profile"])
    @ship = Ship.new(session["ship"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_profile(@profile.attributes)
    @user.build_ship(@ship.attributes).build_address(@address.attributes)
    @user.save
    redirect_to root_path
    sign_in(:user, @user)
  end


  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end

  def profile_params
    params.require(:profile).permit(:profile, :prof_image,:family_name,:first_name,:family_name_kana,:first_name_kana,:birth_day,:mobile)
  end

  def ship_params
    params.require(:ship).permit(:shipping_family_name, :shipping_first_name,:shipping_family_name_kana,:shipping_first_name_kana, :mobile)
  end

  def address_params
    params.require(:address).permit(:post_code, :prefecture,:city,:street_number, :building_name)
  end

  # def ship_params
  #   params.require(:ship).permit(:shipping_family_name,:shipping_first_name,:shipping_family_name_kana,:shipping_first_name_kana,:mobile)
  # end
end
