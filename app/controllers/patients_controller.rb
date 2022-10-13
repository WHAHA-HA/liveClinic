class PatientsController < ApplicationController

  respond_to :json

  def index
    respond_with Patient.where doctor_id: parent_doctor
  end

  def create
    respond_with Patient.create( add_parent_doctor_to_param( patient_params ) )
  end

  def show
    respond_with Patient.find(params[:id])
  end

  def update
    p patient_params
    respond_with Patient.update(params[:id], patient_params)
  end

  def destroy
    respond_with Patient.destroy(params[:id])
  end

  private
  def patient_params
    params.require(:patient).permit(
        :mobile_number,
        :home_phone,
        :work_phone,
        :country,
        :no_mobile,
        :no_email,
        :send_mobile_text,
        :send_voice,
        :send_email,
        :work_ext,
        :method_of_communication,
        :suite,
        :status,
        :f_name,
        :l_name,
        :m_name,
        :n_name,
        :email,
        :avatar,
        :state,
        :city,
        :address,
        :zip,
        :dob,
        :gender,
        :lvd,
        :ssn,
        :insurance_company,
        :insurance_id,
        :ign,
        :isn,
        :ins_subscriber_dob,
        :ins_subscriber_ssn,
        :sec_ssn,
        :sec_insurance_company,
        :sec_insurance_id,
        :sec_ign,
        :sec_isn,
        :sec_ins_subscriber_dob,
        :sec_ins_subscriber_ssn,
    )
  end

end
