require 'test_helper'

class MapControllerTest < ActionController::TestCase
  test "should get viz" do
    get :viz
    assert_response :success
  end

end
