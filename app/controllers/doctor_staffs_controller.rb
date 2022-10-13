class DoctorStaffsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    doctor_staffs = Doctor.find( parent_doctor ).doctor_staffs
    data = []
    doctor_staffs.each do |doctor_staff|
      temp = {}
      temp = doctor_staff.as_json
      temp[:user_attributes] = doctor_staff.user
      data << temp
    end
    respond_with Doctor.find( parent_doctor ), data
  end

  def create
    doctor_staff = DoctorStaff.create( add_parent_doctor_to_param ( doctor_staff_params ) )

    if (doctor_staff)
      data = doctor_staff.as_json
      data[:user_attributes] = doctor_staff.user
      render json: data, status: :created
    else
      render json: doctor_staff.errors, status: :unprocessable_entity
    end
  end

  def show
    respond_with Doctor.find( parent_doctor ), DoctorStaff.find( params[:id] )
  end

  def update
    doctor_staff_params[:user_attributes].delete("password")
    doctor_staff_params[:user_attributes].delete("password_confirmation")
    respond_with Doctor.find( parent_doctor ), DoctorStaff.update(params[:id], doctor_staff_params)
  end

  def destroy
    respond_with Doctor.find( parent_doctor ), DoctorStaff.destroy(params[:id])
  end

  private
  def doctor_staff_params
    params.require(:doctor_staff).permit(
        :access_level_id,
        :is_admin,
        user_attributes: [
            :first_name,
            :last_name,
            :email,
            :provider,
            :password,
            :password_confirmation
        ]
    )
  end
end
