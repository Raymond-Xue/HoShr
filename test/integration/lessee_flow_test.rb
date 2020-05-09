require 'test_helper'

class LesseeFlowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #fixtures :all
  test "can create new lessee request" do
	get "/lessee_requests/new" 
	assert_response :success
	
    #post "/lessee_requests",
	  #params: one
	#assert _response :redirect
  end	
end
