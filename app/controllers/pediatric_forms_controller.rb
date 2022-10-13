class PediatricFormsController < ApplicationController

  respond_to :json

  def index
    respond_with PediatricForm.all
  end

  def create
    respond_with PediatricForm.create(pediatric_form_params)
  end

  def show
    respond_with PediatricForm.find(params[:id])
  end

  def update
    respond_with PediatricForm.update(params[:id], pediatric_form_params)
  end

  def destroy
    respond_with PediatricForm.destroy(params[:id])
  end

  private
  def pediatric_form_params
    params.require(:pediatric_form).permit(
        :patient_id,
        :pri_m,
        :pri_f,
        :pri_b,
        :pri_s,
        :pri_both,
        :pri_other,
        :sec_m,
        :sec_f,
        :sec_other,
        :rel,
        :ch_m,
        :ch_f,
        :ch_sibling,
        :ch_gra,
        :ch_nanny,
        :ch_day_care,
        :tobacco,
        :smokers,
        :cur_smokers
    )
  end

end
