require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pierre = users(:pierre)
    @dante = users(:dante)
  end

  test 'should get JWT token with valid params and uber platform' do
    post login_url(platform: "uber"), params: { email: @pierre.email, password: 'MyPwdChingon123'}, as: :json_response
    
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['access_token']
    assert_equal(json_response["message"], "SUCCESS")
  end

  test 'should get JWT token to dante with valid params and didi platform' do
    post login_url(platform: "didi"), params: { email: @dante.email, password: 'MyPwdChingon123'}, as: :json_response
    
    assert_response :success

    json_response = JSON.parse(response.body)
    assert_not_nil json_response['access_token']
    assert_equal(json_response["message"], "SUCCESS")
  end

  test 'should get JWT token to dante with valid params and uber platform' do
    post login_url(platform: "uber"), params: { email: @dante.email, password: 'MyPwdChingon123'}, as: :json_response
    
    assert_response :unauthorized
    
    json_response = JSON.parse(response.body)
    assert_equal(json_response["message"], "CREDENTIALS_INVALID")
    assert_equal(json_response["details"], "Incorrect username or password")
  end

  test 'should get JWT token with invalid params' do
    post login_url(platform: "uber"), params: nil, as: :json_response

    assert_response :unauthorized

    json_response = JSON.parse(response.body)
    assert_equal(json_response["message"], "CREDENTIALS_INVALID")
    assert_equal(json_response["details"], "Incorrect username or password")
  end

end
