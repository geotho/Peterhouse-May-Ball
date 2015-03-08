require 'test_helper'

class MetricsControllerTest < ActionController::TestCase
  test "should get cashflow" do
    get :cashflow
    assert_response :success
  end

  test "should get payments" do
    get :payments
    assert_response :success
  end

end
