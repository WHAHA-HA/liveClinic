class VitalsController < ApplicationController

  respond_to :json

  def index
    respond_with Vital.all
  end

  def create
    puts vital_params
    respond_with Vital.create(vital_params)
  end

  def show
    respond_with Vital.find(params[:id])
  end

  def update
    respond_with Vital.update(params[:id], vital_params)
  end

  def destroy
    respond_with Vital.destroy(params[:id])
  end

  private
  def vital_params
    params.require(:vital).permit(
        :doctor_id,
        :patient_id,
        :height,
        :weight,
        :bmi,
        :bp,
        :temp,
        :route,
        :pulse,
        :rr,
        :sat,
        :ra,
        :pain,
        :date,
        :encounter_id
    )
  end

end
