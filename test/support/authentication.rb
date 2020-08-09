module Authentication
  def admin_credentials
    user = users(:admin)
    create_session_path(user.email, 'Password123')
  end

  def create_session_path(email, password)
    post v1_sessions_path, headers: password_auth_headers(email, password)

    assert_response :created
    @token = JSON.parse(@response.body)['token']
  end

  def password_auth_headers(email, password)
    user_info = "#{email}:#{password}"
    { 'Authorization': "Basic #{Base64.encode64(user_info)}" }
  end

  def jwt_headers(token)
    { 'Authorization': "BEARER #{token}" }
  end
end