class AppointmentTypesController < ApplicationController

  respond_to :json

  def index
    respond_with AppointmentType.all
  end

  def create
    respond_with AppointmentType.create(appointment_type_params)
  end

  def show
    respond_with AppointmentType.find(params[:id])
  end

  def update
    respond_with AppointmentType.update(params[:id], appointment_type_params)
  end

  def destroy
    respond_with AppointmentType.destroy(params[:id])
  end

  private
  def appointment_type_params
    params.require(:appointment_type).permit(
        :type,
        :status
    )
  end

end
