require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pierre = users(:pierre)
    @dante = users(:dante)
  end

  test 'should get profile when the token is valid' do
    get profile_url(platform: "uber", access_token: @pierre.token), as: :json_response
    json_response = JSON.parse(response.body)
    
    assert_response :success
    
    assert_equal(json_response["message"], "SUCCESS")
    assert_equal(json_response["profile"], @pierre.profile)
    assert_equal(json_response["platform"], @pierre.platform)
  end

  test 'should not get profile when the token is invalid' do
    get profile_url(platform: "uber", access_token: "asdasds"), as: :json_response
    json_response = JSON.parse(response.body)
    assert_response :unauthorized

    assert_equal(json_response["message"], "CREDENTIALS_INVALID")
    assert_equal(json_response["details"], "Incorrect token")
  end
end
