class EncountersController < ApplicationController

  respond_to :json

  def index
    respond_with Encounter.all
  end

  def create
    respond_with Encounter.create(encounter_params)
  end

  def show
    respond_with Encounter.find(params[:id])
  end

  def update
    respond_with Encounter.update(params[:id], encounter_params)
  end

  def destroy
    respond_with Encounter.destroy(params[:id])
  end

  private
  def encounter_params
    params.require(:encounter).permit(
        :doctor_id,
        :patient_id,
        :encounter_type,
        :note_type,
        :date,
        :seen_by,
        :facility,
        :status,
        :chief
    )
  end

end
