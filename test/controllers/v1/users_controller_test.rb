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
      assert_equal response_data.first.keys, %w[id name email role active]
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

    test 'create user' do
      admin_credentials
      params = { email: 'new.user@example.com', name: 'new user',
                 active: true, role: :role_one }

      post v1_users_path, headers: jwt_headers(@token),
                          params: params
      assert_response :created
      response_data = JSON.parse(@response.body)['data']

      assert_equal response_data['name'], 'new user'
      assert_equal response_data['email'], 'new.user@example.com'
      assert_equal response_data['role'], 'role_one'
      assert_equal response_data['active'], true
    end

    test 'update user' do
      admin_credentials
      user = users(:user_one)
      params = { email: 'update@example.com', name: 'new name',
                 active: true, role: :role_two }

      put v1_user_path(user), headers: jwt_headers(@token),
                              params: params
      assert_response :accepted
      response_data = JSON.parse(@response.body)['data']

      assert_equal response_data['name'], 'new name'
      assert_equal response_data['email'], 'update@example.com'
      assert_equal response_data['role'], 'role_two'
      assert_equal response_data['active'], true
    end

    test 'not found user update' do
      admin_credentials
      params = { email: 'update@example.com', name: 'new name',
                 active: true, role: :role_two }

      put v1_user_path(id: 1234), headers: jwt_headers(@token),
                                  params: params
      assert_response :not_found
    end

    test 'invalid update user' do
      admin_credentials
      user = users(:user_one)
      params = { email: 'update',
                 active: true, role: :role_two }

      put v1_user_path(user), headers: jwt_headers(@token),
                              params: params
      assert_response :unprocessable_entity
    end

    test 'delete user' do
      admin_credentials
      user = users(:user_one)

      assert_difference('User.count', -1) do
        delete v1_user_path(user), headers: jwt_headers(@token)
      end

      assert_response :accepted
    end

    test 'not found delete user' do
      admin_credentials
      delete v1_user_path(12345), headers: jwt_headers(@token)
      assert_response :not_found
    end
  end
end
