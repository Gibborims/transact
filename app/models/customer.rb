class Customer < ApplicationRecord
  has_many :transactions, class_name: "Transaction", foreign_key: :customer_id
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true

  validates :phone_number, presence: true
  scope :active, -> { where(is_active: true) }

  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def self.single_record(record_id)
    cust_hash = {}
    customer = Customer.where(id: record_id).first
    if customer
      cust_hash = {
          customer_id: customer.id,
          age: customer.age,
          first_name: customer.first_name,
          last_name: customer.last_name,
          other_names: customer.other_names,
          dob: customer.date_of_birth,
          phone_no: customer.phone_number,
          location: customer.location,
          height: customer.height,
          status: customer.is_active
      }
    end
    cust_hash
  end
end
