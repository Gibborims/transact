module Services
  class GetTransactions
    extend Callable

    def initialize(*cust_id)
      # puts "Argument :: #{cust_id.inspect} ================================="
      transactions = cust_id[0].present? ? Transaction.where(customer_id: cust_id[0]) : Transaction.all
      @transactions = transactions.map do |transaction|
        {
            id: transaction.id,
            transaction_id: transaction.transaction_id,
            customer_id: transaction.customer_id,
            input_amt: transaction.input_amt,
            input_currency: transaction.input_currency,
            output_amt: transaction.output_amt,
            output_currency: transaction.output_currency,
            status: transaction.is_active
        }
      end
    end

    def call
      @transactions
    end
  end
end
