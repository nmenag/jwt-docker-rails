require 'test_helper'

module V1
  class UsersControllerTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'index admin' do
      admin_credentials
      get v1_users_path, headers: jwt_headers(@token)
      assert_response :ok

      response_data = JSON.parse(@response.body)['data']

      assert_equal response_data.size, 2
      assert_equal response_data.first.keys, %w[id name email]
    end

    test 'invalid index' do
      admin_credentials
      token = 'eyJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6IkQrcGp2ejZWSTNBODFSd0dGNWo2RVE9PSIsImV4cCI6MTU5NzAwNjEwNn0.z1vL-a_7Dg9YnqSA1W7fPcN1HuuywgqLajBG_xmVMbc'
      get v1_users_path, headers: jwt_headers(token)
      assert_response :unauthorized
    end

    test 'invalid index without admin access' do
      user = users(:user_two)
      create_session_path(user.email, 'password2')
      get v1_users_path, headers: jwt_headers(@token)
      assert_response :forbidden
    end
  end
end
