class Api::V1::TransactionsController < ApplicationController
  before_action :set_transactions, only: %i[ show update ]

  # Displays all transactions
  def index
    transactions = Services::GetTransactions.call
    render json: { errors: [], rows: transactions }
  end

  # Displays all transactions of a particular customer
  def cust_transactions
    cust_transacts = Services::GetTransactions.new(params[:customer_id]).call
    render json: { errors: [], rows: cust_transacts }
  end

  # Displays a specific transaction by id
  def show
    transaction = Transaction.single_record(@transaction.id)
    logger.info "Transaction in show :: #{transaction.inspect}"
    render json: { resp_code: SUCCESS_CODE, resp_desc: transaction }
  end

  # Creates a transaction
  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.transaction_id = Transaction.trans_generator
    @transaction.is_active = true
    if @transaction.save
      transaction = Transaction.single_record(@transaction.id)
      render json: {resp_code: SUCCESS_CODE, resp_desc: transaction }
    else
      render json: {resp_code: FAIL_CODE, resp_desc: Utils.errors(@transaction)}
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transactions
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:customer_id, :input_amt, :input_currency, :output_amt,
                                        :output_currency, :comment, :is_active)
  end
end
