class DoctorsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with Doctor.all
  end

  def create
    respond_with Doctor.create(doctor_params)
  end

  def show
    respond_with Doctor.find(params[:id])
  end

  def update
    respond_with Doctor.update(params[:id], doctor_params)
  end

  def destroy
    respond_with Doctor.destroy(params[:id])
  end

  def practice
    # respond_to do |format|
    #   format.json { render Doctor.find(params[:id]).practice }
    #   format.json { render  }
    # end
    respond_with Doctor.find(params[:id]).practice
  end

  def getParentDoctor
    #Doctor.find( params[:id] )
  end

  private
  def doctor_params
    params.require(:doctor).permit(
        :price,
        :state_id,
        :title,
        :degree,
        :sex,
        :fax,
        :city,
        :state,
        :p_speciality,
        :p_facility,
        :access_level,
        :s_speciality,
        :p_faculty,
        :web_add,
        :biography,
        :medical_license,
        :expiration,
        :state_practice_medicine,
        :degree_listed,
        :npi_number,
        :dea_number,
        :upin,
        :ein_tin,
        :nadean_number,
        :personal_email,
        :ver_phone,
        :office_phone,
        :extension
    )
  end

end
