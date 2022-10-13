class MedicalHistoriesController < ApplicationController

  respond_to :json

  def index
    respond_with MedicalHistory.all
  end

  def create
    respond_with MedicalHistory.create(medical_history_params)
  end

  def show
    respond_with MedicalHistory.find(params[:id])
  end

  def update
    respond_with MedicalHistory.update(params[:id], medical_history_params)
  end

  def destroy
    respond_with MedicalHistory.destroy(params[:id])
  end

  private
  def medical_history_params
    params.require(:medical_history).permit(
        :doctor_id,
        :patient_id,
        :major_history,
        :ongoing_history,
        :allergy_history,
        :family_history,
        :preventive_history,
        :social_history,
        :nutrition_history,
        :developmental_history,
        :encounter_id
    )
  end

end
