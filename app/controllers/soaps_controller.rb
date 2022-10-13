class SoapsController < ApplicationController

  respond_to :json

  def index
    respond_with Soap.all
  end

  def create
    respond_with Soap.create(soap_params)
  end

  def show
    respond_with Soap.find(params[:id])
  end

  def update
    respond_with Soap.update(params[:id], soap_params)
  end

  def destroy
    respond_with Soap.destroy(params[:id])
  end

  private
  def soap_params
    params.require(:soap).permit(
        :doctor_id,
        :patient_id,
        :note_subjective,
        :note_objective,
        :note_assessment,
        :note_plan,
        :encounter_id
    )
  end

end
