FactoryBot.define do
  factory :customer do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    other_names { Faker::Name.name }
    date_of_birth { Faker::Date.between(from: '1900-09-23', to: '2009-09-25') }
    phone_number { Faker::PhoneNumber.cell_phone_in_e164 }
    location { Faker::Address.city }
    height { "#{Faker::Number.decimal(l_digits: 2)}"  }
  end
end
