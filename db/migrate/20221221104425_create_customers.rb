class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.string :other_names
      t.string :phone_number
      t.date :date_of_birth
      t.decimal :height
      t.string :location
      t.text :comment
      t.boolean :is_active

      t.timestamps
    end
  end
end
