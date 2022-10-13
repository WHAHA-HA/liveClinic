class ProfileController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show
    profile = current_user.user_profile || {}
    respond_with profile
  end

  def update
    if current_user.user_profile.present?
      current_user.user_profile.update(profile_params)
    else
      user_profile = UserProfile.create(profile_params)
      current_user.user_profile_id = user_profile.id
      current_user.save();
    end
    
    respond_with user_profile
  end

private
  def profile_params
    params.permit(
      :personal_email,
      :office_phone,
      :fax,
      :degree,
      :sex,
      :primary_specialty,
      :access_level,
      :facility_id,
      :city,
      :state,
      :practice_web_addr,
      :biography,

      :medical_license,
      :expiration,
      :state_practiced,
      :specialty_on_license,
      :dea_number,
      :upin,
      :ein_tin,
      :npi_number,
      :nadean_number,

      :sfax_apikey,
      :sfax_username,
      :sfax_encryptionkey,

      :phimail_email,
      :phimail_password
    )
  end
end
