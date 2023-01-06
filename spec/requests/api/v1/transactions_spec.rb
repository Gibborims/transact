require 'rails_helper'

RSpec.describe "Api::V1::Transactions", type: :request do

  describe "GET /index" do
    let!(:customer) { FactoryBot.create(:customer) }
    before do
      FactoryBot.create_list(:transaction, 2, customer_id: customer.id)
      get '/api/v1/transactions'
    end

    it 'returns all transactions' do
      expect(json["rows"].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end


  describe "GET /show" do
    let!(:customer) { FactoryBot.create(:customer) }
    let!(:transaction) { FactoryBot.create(:transaction, customer_id: customer.id) }
    let!(:trans_id) { transaction.id }
    before do
      get "/api/v1/transactions/#{trans_id}"
    end

    context "with valid transaction id" do
      it 'returns the specific transaction id' do
        expect(json["resp_desc"]["id"]).to eq(trans_id)
      end
  
      it 'returns response code 000' do
        expect(json["resp_code"]).to eq(success)
      end
    end

    context "with non-existing or wrong id" do
      let(:trans_id) { 1 }
      
      it 'returns response code 101' do
        expect(json["resp_code"]).to eq(fail)
      end

      it 'returns response fail description' do
        expect(json["resp_desc"]).to eq("Couldn't find Transaction with 'id'=#{trans_id}")
      end
    end

  end




  describe "GET /create" do
    context "with valid parameters" do
      let!(:customer) { FactoryBot.create(:customer) }
      let(:valid_params) do
        { transaction: {
            customer_id: customer.id,
            input_amt: Faker::Number.decimal(l_digits: 2),
            input_currency: Faker::Currency.code,
            output_amt: Faker::Number.decimal(l_digits: 2),
            output_currency: Faker::Currency.code,
            is_active: true
        }}
      end

      it "creates a new transaction" do
        expect { post "/api/v1/transactions", params: valid_params}.to change(Transaction, :count).by(1)
        expect(response).to have_http_status(200)  # it's use for code 200
      end

      it "creates a transaction with the correct attributes value" do
        post "/api/v1/transactions", params: valid_params
        expect(json["resp_code"]).to eq(success)
        expect(json["resp_desc"]["input_amt"]).to eq(valid_params[:transaction][:input_amt].to_s)
      end
    end

    context "with invalid parameters" do
      # testing for validation failures is just as important!
      let(:valid_params) do
        {
          transaction: {
            input_amt: "#{Faker::Number.decimal(l_digits: 2)}",
            input_currency: Faker::Currency.code,
            output_amt: "#{Faker::Number.decimal(l_digits: 2)}",
            output_currency: Faker::Currency.code,
            is_active: true
          }
        }
      end

      it "cannot create a new transaction due to validation error" do
        expect { post "/api/v1/transactions", params: valid_params}.to change(Transaction, :count).by(0)
        expect(response).to have_http_status(200)  # it's use for code 200
      end

      it "cannot create a transaction with the wrong attributes" do
        post "/api/v1/transactions", params: valid_params
        expect(json["resp_code"]).to eq(fail)
      end

    end
  end

  describe "GET /update" do
    context "with valid parameters" do
      let!(:customer) { FactoryBot.create(:customer) }
      let!(:transact) { FactoryBot.create(:transaction, customer_id: customer.id) }
      let(:valid_params) do
        { 
          transaction: {
            customer_id: customer.id,
            input_amt: Faker::Number.decimal(l_digits: 2).to_s,
            input_currency: Faker::Currency.code,
            output_amt: Faker::Number.decimal(l_digits: 2).to_s,
            output_currency: Faker::Currency.code,
            is_active: true
          }
        }
      end

      it 'should update transaction details' do
        put "/api/v1/transactions/#{transact.id}",
            params: valid_params,
            as: :json
        expect(response).to have_http_status(200)
        expect(json["resp_code"]).to eq(success)
        expect(json["resp_desc"]["input_amt"].to_s).to eq(valid_params[:transaction][:input_amt])
      end
    end
  end
end
