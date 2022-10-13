class PatientRegistrationsController < ApplicationController

  respond_to :json

  def index
    respond_with PatientRegistration.all
  end

  def create
    respond_with PatientRegistration.create(patient_registration_params)
  end

  def show
    respond_with PatientRegistration.find(params[:id])
  end

  def update
    respond_with PatientRegistration.update(params[:id], patient_registration_params)
  end

  def destroy
    respond_with PatientRegistration.destroy(params[:id])
  end

  private
  def patient_registration_params
    params.require(:patient_registration).permit(
        :doctor_id,
        :patient_id,
        :allergy,
        :search,
        :severity,
        :reaction,
        :onset,
        :date,
        :comment,
        :status
    )
  end

end
