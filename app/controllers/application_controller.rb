class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # respond_to :html, :json
  # protect_from_forgery with: :exception
  include ActionController::MimeResponds

  def angular
    render 'layouts/application'
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_devise_permitted_parameters
    # devise_parameter_sanitizer.for(:sign_up_params) { |u| u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :confirm_success_url) }
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:first_name, :last_name, :phone)
    end
    # devise_parameter_sanitizer.for(:account_update_params) { |u| u.permit(:first_name, :last_name, :phone, :email, :password, :password_confirmation, :confirm_success_url, :current_password) }
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :middle_name, :last_name, :phone, :email, :password, :password_confirmation, :avatar, :avatar_cache, :title])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :middle_name, :last_name, :phone, :email, :avatar, :avatar_cache, :remove_avatar, :title])
  end

  # helper
  def parent_doctor
    return false unless current_user

    if current_user.is_doctor? 
      return current_user.owner_id
    elsif current_user.owner_type == 'DoctorStaff'
      return current_user.owner.doctor_id
    end
  end

  def add_parent_doctor_to_param( param, column: "doctor_id" )
    param.to_h.merge({column => parent_doctor})
  end

end
