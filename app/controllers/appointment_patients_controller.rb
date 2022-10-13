class AppointmentPatientsController < ApplicationController

  respond_to :json

  def index
    respond_with AppointmentPatient.all
  end

  def create
    respond_with AppointmentPatient.create(appointment_patient_params)
  end

  def show
    respond_with AppointmentPatient.find(params[:id])
  end

  def update
    respond_with AppointmentPatient.update(params[:id], appointment_patient_params)
  end

  def destroy
    respond_with AppointmentPatient.destroy(params[:id])
  end

  private
  def appointment_patient_params
    params.require(:appointment_patient).permit(
        :doctor_id,
        :patient_id,
        :patient_name,
        :provider,
        :facility,
        :chief_complaint,
        :appointment_type_id,
        :duration,
        :duration_select,
        :when_time,
        :end_time,
        :repeat_val,
        :repeats,
        :occurs_on,
        :every_day,
        :ends_on,
        :string,
        :after,
        :daily,
        :every_week
    )
  end

end
