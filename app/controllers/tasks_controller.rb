class TasksController < ApplicationController

  respond_to :json

  def index
    temp = [];
    Task.includes(:patient).where(doctor_id: parent_doctor).each do |task|
      temp << {
        id: task.id,
        name: task.name,
        due_date: task.due_date,
        desc: task.desc,
        patient_id: task.patient_id,
        doctor_id: task.doctor_id,
        created_at: task.created_at,
        updated_at: task.updated_at,
        provider_id: task.provider_id,
        active: task.active,
        patient: {
          id: task.patient.id,
          f_name: task.patient.f_name,
          l_name: task.patient.l_name
        }
      }
    end
    respond_with temp
  end

  def create
    respond_with Task.create( add_parent_doctor_to_param( task_params ) )
  end

  def show
    respond_with Task.find(params[:id])
  end

  def update
    respond_with Task.update(params[:id], task_params)
  end

  def destroy
    respond_with Task.destroy(params[:id])
  end

  private
  def task_params
    params.require(:task).permit(
        :id,
        :doctor_id,
        :active,
        :patient_id,
        :name,
        :due_date,
        :provider_id,
        :desc
    )
  end

end
