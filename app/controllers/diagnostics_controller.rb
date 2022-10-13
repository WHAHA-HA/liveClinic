class DiagnosticsController < ApplicationController

  respond_to :json

  def index
    respond_with Diagnostic.all
  end

  def create
    respond_with Diagnostic.create(diagnostic_params)
  end

  def show
    respond_with Diagnostic.find(params[:id])
  end

  def update
    respond_with Diagnostic.update(params[:id], diagnostic_params)
  end

  def destroy
    respond_with Diagnostic.destroy(params[:id])
  end

  private
  def diagnostic_params
    params.require(:diagnostic).permit(
        :doctor_id,
        :diagnosis,
        :medication,
        :charge,
        :request_id
    )
  end

end
