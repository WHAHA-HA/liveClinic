class RequestsController < ApplicationController

  respond_to :json

  def index
    respond_with Request.all
  end

  def create
    respond_with Request.create(request_params)
  end

  def show
    respond_with Request.find(params[:id])
  end

  def update
    respond_with Request.update(params[:id], request_params)
  end

  def destroy
    respond_with Request.destroy(params[:id])
  end

  private
  def request_params
    params.require(:request).permit(
        :doctor_id,
        :patient_id,
        :creation_time,
        :symptoms,
        :allergy,
        :complicated,
        :pharmacy_phone,
        :is_video,
        :charge_id,
        :rating
    )
  end

end
