class ShortHandsController < ApplicationController

  respond_to :json

  def index
    respond_with ShortHand.all
  end

  def create
    respond_with ShortHand.create(short_hand_params)
  end

  def show
    respond_with ShortHand.find(params[:id])
  end

  def update
    respond_with ShortHand.update(params[:id], short_hand_params)
  end

  def destroy
    respond_with ShortHand.destroy(params[:id])
  end

  private
  def short_hand_params
    params.require(:short_hand).permit(
        :name,
        :status
    )
  end

end
