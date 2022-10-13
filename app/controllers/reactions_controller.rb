class ReactionsController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def index
    respond_with Reaction.all
  end

  def create
    respond_with Reaction.create(reaction_params)
  end

  def show
    respond_with Reaction.find(params[:id])
  end

  def update
    respond_with Reaction.update(params[:id], reaction_params)
  end

  def destroy
    respond_with Reaction.destroy(params[:id])
  end

  private
  def reaction_params
    params.require(:reaction).permit(
        :name,
        :status
    )
  end

end
