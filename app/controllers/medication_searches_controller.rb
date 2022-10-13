class MedicationSearchesController < ApplicationController

  respond_to :json

  def index
    respond_with MedicationSearch.all
  end

  def create
    respond_with MedicationSearch.create(medication_search_params)
  end

  def show
    respond_with MedicationSearch.find(params[:id])
  end

  def update
    respond_with MedicationSearch.update(params[:id], medication_search_params)
  end

  def destroy
    respond_with MedicationSearch.destroy(params[:id])
  end

  private
  def medication_search_params
    params.require(:medication_search).permit(
        :appl_no,
        :product_no,
        :form,
        :dosage,
        :product_mkt_status,
        :te_code,
        :reference_drug,
        :m_name,
        :active_ingred
    )
  end

end
