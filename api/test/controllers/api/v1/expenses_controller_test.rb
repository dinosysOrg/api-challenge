require 'test_helper'

class Api::V1::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should post import_data" do
    post api_v1_expenses_import_data_url
    assert_response :success
  end

end
