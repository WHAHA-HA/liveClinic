class CtpCodesController < ApplicationController

  respond_to :json

  def index
    respond_with CtpCode.all
  end

  def create
    respond_with CtpCode.create(ctp_code_params)
  end

  def show
    respond_with CtpCode.find(params[:id])
  end

  def update
    respond_with CtpCode.update(params[:id], ctp_code_params)
  end

  def destroy
    respond_with CtpCode.destroy(params[:id])
  end

  private
  def ctp_code_params
    params.require(:ctp_code).permit(
        :concept_id,
        :code,
        :descriptor_id,
        :descriptor
    )
  end

end
