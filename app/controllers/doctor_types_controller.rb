class DoctorTypesController < ApplicationController

  respond_to :json

  def index
    respond_with DoctorType.all
  end

  def create
    respond_with DoctorType.create(doctor_type_params)
  end

  def show
    respond_with DoctorType.find(params[:id])
  end

  def update
    respond_with DoctorType.update(params[:id], doctor_type_params)
  end

  def destroy
    respond_with DoctorType.destroy(params[:id])
  end

  private
  def doctor_type_params
    params.require(:doctor_type).permit(:code, :name)
  end

end
