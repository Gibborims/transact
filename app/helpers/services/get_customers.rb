module Services
  class GetCustomers
    extend Callable

    def initialize
      @customers = Customer.all.map do |customer|
        {
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
    end

    def call
      @customers
    end
  end
end
