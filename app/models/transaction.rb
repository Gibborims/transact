class Transaction < ApplicationRecord
    require "bigdecimal"
  belongs_to :a_customer, class_name: "Customer", foreign_key: :customer_id

  validates :customer_id, presence: true
  validates :input_amt, numericality: { greater_than: 0 }
  validates :input_currency, presence: true
  validates :output_amt, numericality: { greater_than: 0 }
  validates :output_currency, presence: true

  def self.single_record(trans_id)
    trans_hash = {}
    transaction = Transaction.where(id: trans_id).first
    if transaction
      trans_hash = {
        id: transaction.id,
        customer_id: transaction.customer_id,
        input_amt: (BigDecimal(transaction.input_amt)).to_s,
        input_currency: transaction.input_currency,
        output_amt: (BigDecimal(transaction.output_amt)).to_s,
        output_currency: transaction.output_currency,
        status: transaction.is_active
      }
    end
    trans_hash
  end
end
