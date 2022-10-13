class MedicationYearsController < ApplicationController

  respond_to :json

  def index
    respond_with MedicationYear.all
  end

  def create
    respond_with MedicationYear.create(medication_year_params)
  end

  def show
    respond_with MedicationYear.find(params[:id])
  end

  def update
    respond_with MedicationYear.update(params[:id], medication_year_params)
  end

  def destroy
    respond_with MedicationYear.destroy(params[:id])
  end

  private
  def medication_year_params
    params.require(:medication_year).permit(
        :patient_id,
        :date1,
        :date2,
        :date3,
        :date4,
        :date5,
        :date6,
        :date7,
        :date8,
        :date9,
        :date10,
        :date11,
        :date12,
        :date13,
        :date14,
        :date15,
        :date16,
        :date17,
        :date18,
        :date19,
        :date20,
        :date21,
        :date22,
        :date23,
        :date24,
        :date25,
        :date26,
        :date27,
        :date28,
        :date29,
        :date30,
        :date31,
        :date32,
        :date33,
        :date34
    )
  end

end
