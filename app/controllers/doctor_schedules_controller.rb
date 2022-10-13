class DoctorSchedulesController < ApplicationController

  respond_to :json

  def index
    respond_with DoctorSchedule.where doctor_id: parent_doctor
  end

  def create
    respond_with DoctorSchedule.create( add_parent_doctor_to_param( doctor_schedule_params ) )
  end

  def show
    respond_with DoctorSchedule.find(params[:id])
  end

  def update
    respond_with DoctorSchedule.update(params[:id], doctor_schedule_params)
  end

  def destroy
    respond_with DoctorSchedule.destroy(params[:id])
  end

  private
  def doctor_schedule_params
    params.require(:doctor_schedule).permit(
      :doctor_id, 
      :facility_id,
      :patient_id,
      :start_time, 
      :end_time, 
      :title
    )
  end

end
