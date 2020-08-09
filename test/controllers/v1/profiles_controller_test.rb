require 'test_helper'

module V1
  class ProfilesControllerTest < ActionDispatch::IntegrationTest
    include Authentication

    test 'show user one' do
      user = users(:user_one)
      create_session_path(user.email, 'password1')
      get v1_profile_path, headers: jwt_headers(@token)
      assert_response :ok

      response_data = JSON.parse(@response.body)['data']

      assert_equal response_data['name'], 'User one'
      assert_equal response_data['email'], 'user.one@example.com'
    end

    test 'show user two' do
      user = users(:user_two)
      create_session_path(user.email, 'password2')
      get v1_profile_path, headers: jwt_headers(@token)
      assert_response :ok

      response_data = JSON.parse(@response.body)['data']

      assert_equal response_data['name'], 'User Two'
      assert_equal response_data['email'], 'user.two@example.com'
    end

    test 'invalid show' do
      user = users(:user_two)
      create_session_path(user.email, 'password2')
      token  = 'eyJhbGciOiJIUzI1NiJ9.eyJ0b2tlbiI6IlZhbTQzN0VHdDlTYmZvenJrdkVDM3c9PSIsImV4cCI6MTU5NzAxMDA2Nn0.a2dr152Wp2KuuBj4q5HWyZXwAOvtyp2uMQVj-lpuV9o'
      get v1_profile_path, headers: jwt_headers(token)
      assert_response :unauthorized
    end
  end
end
