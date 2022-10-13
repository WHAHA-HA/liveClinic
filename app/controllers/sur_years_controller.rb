class SurYearsController < ApplicationController

  respond_to :json

  def index
    respond_with SurYear.all
  end

  def create
    respond_with SurYear.create(sur_year_params)
  end

  def show
    respond_with SurYear.find(params[:id])
  end

  def update
    respond_with SurYear.update(params[:id], sur_year_params)
  end

  def destroy
    respond_with SurYear.destroy(params[:id])
  end

  private
  def sur_year_params
    params.require(:sur_year).permit(
        :patient_id,
        :name1,
        :name2,
        :name3,
        :name4,
        :name5,
        :name6,
        :name7,
        :name8,
        :name9,
        :name10,
        :name11,
        :name12,
        :name13,
        :name14,
        :name15,
        :name16,
        :name17,
        :name18,
        :name19,
        :name20,
        :name21,
        :name22,
        :name23,
        :name24,
        :name25,
        :name26,
        :name27,
        :name28,
        :name29,
        :name30,
        :name31,
        :name32,
        :name33,
        :name34,
        :name35,
        :name36,
        :name37,
        :name38,
        :name39,
        :name40
    )
  end

end