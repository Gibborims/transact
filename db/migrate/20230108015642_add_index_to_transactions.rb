class AddIndexToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_index :transactions, :customer_id
  end
end
