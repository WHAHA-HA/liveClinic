class CountriesController < ApplicationController

  respond_to :json

  def index
    respond_with Country.all
  end

  def create
    respond_with Country.create(country_params)
  end

  def show
    respond_with Country.find(params[:id])
  end

  def update
    respond_with Country.update(params[:id], country_params)
  end

  def destroy
    respond_with Country.destroy(params[:id])
  end

  private
  def country_params
    params.require(:country).permit(:ios, :name, :nicename, :nicename, :ios3, :numcode, :phonecode)
  end

end
