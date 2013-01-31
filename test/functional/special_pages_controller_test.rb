require 'test_helper'

class SpecialPagesControllerTest < ActionController::TestCase
  test "should get best_weeks" do
    get :best_weeks
    assert_response :success
  end

end
