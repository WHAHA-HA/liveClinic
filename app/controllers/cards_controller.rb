class CardsController < ApplicationController

  respond_to :json

  def index
    respond_with Card.all
  end

  def create
    respond_with Card.create(card_params)
  end

  def show
    respond_with Card.find(params[:id])
  end

  def update
    respond_with Card.update(params[:id], card_params)
  end

  def destroy
    respond_with Card.destroy(params[:id])
  end

  private
  def card_params
    params.require(:card).permit(:user_id, :customer, :card)
  end

end
