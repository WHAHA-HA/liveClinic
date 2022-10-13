class AllergiesController < ApplicationController

  respond_to :json

  def index
    respond_with Allergy.all
  end

  def create
    respond_with Allergy.create(allergy_params)
  end

  def show
    respond_with Allergy.find(params[:id])
  end

  def update
    respond_with Allergy.update(params[:id], allergy_params)
  end

  def destroy
    respond_with Allergy.destroy(params[:id])
  end

  private
  def allergy_params
    params.require(:allergy).permit(
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
