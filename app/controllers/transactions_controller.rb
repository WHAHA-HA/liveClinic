class TransactionsController < ApplicationController

  respond_to :json

  def index
    respond_with Transaction.all
  end

  def create
    respond_with Transaction.create(transaction_params)
  end

  def show
    respond_with Transaction.find(params[:id])
  end

  def update
    respond_with Transaction.update(params[:id], transaction_params)
  end

  def destroy
    respond_with Transaction.destroy(params[:id])
  end

  private
  def transaction_params
    params.require(:transaction).permit(
        :request_id,
        :price,
        :date
    )
  end

end
