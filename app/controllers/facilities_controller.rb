class FacilitiesController < ApplicationController

  respond_to :json

  def index
    respond_with Facility.where doctor_id: parent_doctor
  end

  def create
    respond_with Facility.create( add_parent_doctor_to_param( facility_params ) );
  end

  def show
    respond_with Facility.find(params[:id])
  end

  def update
    respond_with Facility.update(params[:id], facility_params)
  end

  def destroy
    respond_with Facility.destroy(params[:id])
  end

  private
  def facility_params
    params.require(:facility).permit(
        :name,
        :phone,
        :fax,
        :address,
        :zip,
        :city,
        :country,
        :state,
        :status
    )
  end

end
