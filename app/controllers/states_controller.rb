class StatesController < ApplicationController

  respond_to :json

  def index
    respond_with State.all
  end

  def create
    respond_with State.create(state_params)
  end

  def show
    respond_with State.find(params[:id])
  end

  def update
    respond_with State.update(params[:id], state_params)
  end

  def destroy
    respond_with State.destroy(params[:id])
  end

  private
  def state_params
    params.require(:state).permit(:name, :code)
  end

end
