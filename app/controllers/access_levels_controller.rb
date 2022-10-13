class AccessLevelsController < ApplicationController
  
  before_action :authenticate_user!
  respond_to :json

  def index
    respond_with AccessLevel.all
  end

  def create
    respond_with AccessLevel.create(access_level_params)
  end

  def show
    respond_with AccessLevel.find(params[:id])
  end

  def update
    respond_with AccessLevel.update(params[:id], access_level_params)
  end

  def destroy
    respond_with AccessLevel.destroy(params[:id])
  end

  private
  def access_level_params
    params.require(:access_level).permit(
        :name
    )
  end
  
end
