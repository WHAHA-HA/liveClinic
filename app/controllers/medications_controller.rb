class MedicationsController < ApplicationController

  respond_to :json

  def index
    respond_with Medication.all
  end

  def create
    respond_with Medication.create(medication_params)
  end

  def show
    respond_with Medication.find(params[:id])
  end

  def update
    respond_with Medication.update(params[:id], medication_params)
  end

  def destroy
    respond_with Medication.destroy(params[:id])
  end

  private
  def medication_params
    params.require(:medication).permit(
        :doctor_id,
        :patient_id,
        :search,
        :shorthand,
        :sig,
        :diagnosis,
        :start_date,
        :end_date,
        :dis_reason,
        :comment,
        :status,
        :form,
        :dosage,
        :product_no,
        :fev
    )
  end

end
