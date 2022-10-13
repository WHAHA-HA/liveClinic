class AllergySearchSearchesController < ApplicationController

  respond_to :json

  def index
    respond_with AllergySearch.all
  end

  def create
    respond_with AllergySearch.create(allergy_search_params)
  end

  def show
    respond_with AllergySearch.find(params[:id])
  end

  def update
    respond_with AllergySearch.update(params[:id], allergy_search_params)
  end

  def destroy
    respond_with AllergySearch.destroy(params[:id])
  end

  private
  def allergy_search_params
    params.require(:allergy_search).permit(
        :allergy_id,
        :allergy_name,
        :allergy_status
    )
  end

end
