class CallsController < ApplicationController

  respond_to :json

  def index
    respond_with Call.all
  end

  def create
    respond_with Call.create(call_params)
  end

  def show
    respond_with Call.find(params[:id])
  end

  def update
    respond_with Call.update(params[:id], call_params)
  end

  def destroy
    respond_with Call.destroy(params[:id])
  end

  private
  def call_params
    params.require(:call).permit(:call_time, :calls_col, :request_id)
  end

end
