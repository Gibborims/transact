require "test_helper"

class Api::V1::CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_customers_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_customers_show_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_customers_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_customers_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_customers_destroy_url
    assert_response :success
  end
end
