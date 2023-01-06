class Api::V1::TransactionsController < ApplicationController
  before_action :set_transactions, only: %i[ show update ]

  # Displays all transactions
  def index
    render json: { errors: [], rows: Services::GetTransactions.call }
  end

  # Displays all transactions of a particular customer
  def cust_transactions
    cust_transacts = Services::GetTransactions.new(params[:customer_id]).call
    render json: { errors: [], rows: cust_transacts }
  end

  # Displays a specific transaction by id
  def show
    render json: { resp_code: SUCCESS_CODE, resp_desc: Transaction.single_record(@transaction.id) }
  end

  # Creates a transaction
  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      render json: {resp_code: SUCCESS_CODE, resp_desc: Transaction.single_record(@transaction.id) }
    else
      render json: {resp_code: FAIL_CODE, resp_desc: Utils.errors(@transaction)}
    end
  end

  # Update a transaction
  def update
    if @transaction.update(transaction_params)
      render json: {resp_code: SUCCESS_CODE, resp_desc: Transaction.single_record(@transaction.id) }
    else
      render json: { resp_code: FAIL_CODE, resp_desc: Utils.errors(@transaction) }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transactions
    @transaction = Transaction.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: {resp_code: FAIL_CODE, resp_desc: e }
  end

  def transaction_params
    params.require(:transaction).permit(:customer_id, :input_amt, :input_currency, :output_amt,
                                        :output_currency, :comment, :is_active)
  end
end
