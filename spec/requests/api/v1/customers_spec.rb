require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do

  describe "GET /index" do
    before do
      FactoryBot.create_list(:customer, 2)
      get '/api/v1/customers'
    end

    it 'returns all customers' do
      expect(json["rows"].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET /show" do
    let!(:customer) { FactoryBot.create(:customer) }
    let!(:cust_id) { customer.id }
    before do
      get "/api/v1/customers/#{cust_id}"
    end

    it 'returns the specific customer id' do
      expect(json["resp_desc"]["customer_id"]).to eq(cust_id)
    end

    it 'returns response code 000' do
      expect(json["resp_code"]).to eq(success)
    end

  end




  describe "GET /create" do
    context "with valid parameters" do
      let(:valid_params) do
        { customer: {
            first_name: Faker::Name.name,
            last_name: Faker::Name.name,
            other_names: Faker::Name.name,
            date_of_birth: Faker::Date.between(from: '1900-09-23', to: '2009-09-25'),
            phone_number: Faker::PhoneNumber.cell_phone_in_e164,
            location: Faker::Address.city,
            height: Faker::Number.decimal(l_digits: 2),
            is_active: true
        }}
      end

      it "creates a new customer" do
        expect { post "/api/v1/customers", params: valid_params}.to change(Customer, :count).by(1)
        expect(response).to have_http_status(200)  # it's use for code 200
      end

      it "creates a customer with the correct attributes" do
        post "/api/v1/customers", params: valid_params
        expect(Customer.order(id: :desc).first).to have_attributes valid_params[:customer]
        expect(json["resp_code"]).to eq(success)
      end
    end

    context "with invalid parameters" do
      # testing for validation failures is just as important!
      let(:valid_params) do
        { customer: {
          first_name: Faker::Name.name,
          last_name: Faker::Name.name,
          date_of_birth: Faker::Date.between(from: '1900-09-23', to: '2009-09-25'),
          phone_number: '',
          location: Faker::Address.city,
          status: true
        }}
      end

      it "cannot create a new customer due to validation error" do
        expect { post "/api/v1/customers", params: valid_params}.to change(Customer, :count).by(0)
        expect(response).to have_http_status(200)  # it's use for code 200
      end

      it "cannot create a customer with the wrong attributes" do
        post "/api/v1/customers", params: valid_params
        expect(json["resp_code"]).to eq(fail)
      end

    end
  end



  describe "PUT /update" do
    context 'valid parameters value' do
      let!(:customer) { FactoryBot.create(:customer) }
      let(:valid_params) do
        {   
          customer: {
            customer_id: customer.id,
            first_name: customer.first_name,
            last_name: customer.last_name,
            other_names: customer.other_names,
            date_of_birth: customer.date_of_birth,
            phone_number: Faker::PhoneNumber.cell_phone_in_e164,
            location: customer.location,
            height: customer.height
          }
        }
      end

      it 'should update customer details' do
        put "/api/v1/customers/#{customer.id}",
              params: valid_params,
              as: :json
        expect(response).to have_http_status(200)
        expect(json["resp_code"]).to eq(success)
        expect(json["resp_desc"]["phone_no"]).to eq(valid_params[:customer][:phone_number])
      end
    end


    context 'invalid parameter value for phone number' do
      let!(:customer) { FactoryBot.create(:customer) }
      let(:valid_params) do
        { 
          customer: {
            customer_id: customer.id,
            first_name: customer.first_name,
            last_name: customer.last_name,
            date_of_birth: customer.date_of_birth,
            phone_number: '',
            location: customer.location
          }
        }
      end

      it 'cannot update customer details' do
        put "/api/v1/customers/#{customer.id}",
            params: valid_params,
            as: :json
        expect(response).to have_http_status(200)
        expect(json["resp_code"]).to eq(fail)
        expect(Customer.where(id: customer.id).order(id: :desc).first.phone_number).to eq(customer.phone_number)
      end
    end

  end


end
