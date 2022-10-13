class PracticesController < ApplicationController
  respond_to :json

  def show
    respond_with Practice.where(doctor_id: parent_doctor).first
  end

  def update
    practice_info = Practice.where(doctor_id: parent_doctor).first;

    if practice_info
      Practice.update(practice_info.id, practice_params)
    else
      create
    end

    render json: { 'success'=> 'ok' }
  end

  def create
    Practice.create(add_parent_doctor_to_param(practice_params))
    render json: { 'success'=> 'ok' }
  end

  private

  def practice_params
    params.require(:practice).permit(
        :name,
        :phone,
        :fax,
        :address,
        :suite,
        :zip,
        :city,
        :country,
        :status,
        :state,
        :time_zone,
        :facility_name
    )
  end

end
