class ChitChatsController < ApplicationController

  respond_to :json

  def index
    respond_with ChitChat.all
  end

  def create
    respond_with ChitChat.create(chit_chat_params)
  end

  def show
    respond_with ChitChat.find(params[:id])
  end

  def update
    respond_with ChitChat.update(params[:id], chit_chat_params)
  end

  def destroy
    respond_with ChitChat.destroy(params[:id])
  end

  private
  def chit_chat_params
    params.require(:chit_chat).permit(
        :doctor_id,
        :patient_id,
        :encounter_id,
        :chit_chat,
        :status,
        :status,
        :date
    )
  end

end
