class SupperBillsController < ApplicationController

  respond_to :json

  def index
    respond_with SupperBill.all
  end

  def create
    respond_with SupperBill.create(supper_bill_params)
  end

  def show
    respond_with SupperBill.find(params[:id])
  end

  def update
    respond_with SupperBill.update(params[:id], supper_bill_params)
  end

  def destroy
    respond_with SupperBill.destroy(params[:id])
  end

  private
  def supper_bill_params
    params.require(:supper_bill).permit(
        :doctor_id,
        :patient_id,
        :encounter_id,
        :name,
        :date
    )
  end

end
