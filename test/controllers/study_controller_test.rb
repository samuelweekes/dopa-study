require 'test_helper'

class StudyControllerTest < ActionDispatch::IntegrationTest
  test "should get complete" do
    get study_complete_url
    assert_response :success
  end

end
