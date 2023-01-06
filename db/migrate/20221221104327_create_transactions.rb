class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :customer_id
      t.decimal :input_amt, precision: 10, scale: 2
      t.string :input_currency
      t.decimal :output_amt, precision: 10, scale: 2
      t.string :output_currency
      t.text :comment
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
