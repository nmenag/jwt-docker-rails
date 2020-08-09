require 'test_helper'

module V1
  class SessionsControllerTest < ActionDispatch::IntegrationTest

    setup do
      @user = users(:user_one)
    end

    test "create" do
      post v1_sessions_path, headers: password_auth_headers
      assert_response :created

      response_data = JSON.parse(@response.body)

      assert_equal response_data['name'], @user.name
      assert_equal response_data['email'], @user.email
      assert response_data['token'].present?
    end

    test "create unauthorized" do
      post v1_sessions_path, headers: invalid_password_auth_headers
      assert_response :unauthorized
    end


    private

    def password_auth_headers
      { 'Authorization':
        "Basic #{Base64.encode64('user.one@example.com:password1')}" }
    end

    def invalid_password_auth_headers
      { 'Authorization':
        "Basic #{Base64.encode64('user.one@example.com:passwrong')}" }
    end
  end
end
