class HealthExamDatesController < ApplicationController

  respond_to :json

  def index
    respond_with HealthExamDate.all
  end

  def create
    respond_with HealthExamDate.create(health_exam_date_params)
  end

  def show
    respond_with HealthExamDate.find(params[:id])
  end

  def update
    respond_with HealthExamDate.update(params[:id], health_exam_date_params)
  end

  def destroy
    respond_with HealthExamDate.destroy(params[:id])
  end

  private
  def health_exam_date_params
    params.require(:health_exam_date).permit(
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
        :date20
    )
  end

end
