class SocialAdultsController < ApplicationController

  respond_to :json

  def index
    respond_with SocialAdult.all
  end

  def create
    respond_with SocialAdult.create(social_adult_params)
  end

  def show
    respond_with SocialAdult.find(params[:id])
  end

  def update
    respond_with SocialAdult.update(params[:id], social_adult_params)
  end

  def destroy
    respond_with SocialAdult.destroy(params[:id])
  end

  private
  def social_adult_params
    params.require(:social_adult).permit(
        :patient_id,
        :children,
        :tobacco_no,
        :tobacco_daily,
        :tobacco_weekly,
        :tobacco_former,
        :alcohol_no,
        :alcohol_daily,
        :alcohol_weekly,
        :alcohol_less,
        :alcohol_former,
        :ex_mod,
        :ex_vig,
        :sed,
        :caff_no,
        :caff_daily,
        :caff_weekly,
        :caff_less,
        :caff_former,
        :fm_che,
        :fm_pipe,
        :fm_cig,
        :fm_cigarette,
        :fm_beer,
        :fm_liquor,
        :fm_other,
        :changes,
        :chocolate,
        :coffee,
        :soda,
        :tea,
        :tablet,
        :c_other,
        :fm_smokeless,
        :how_many
    )
  end

end
