module SigninSpecHelper
  def signin(user)
    post '/auth/login', params: { email: user.email, password: user.password }
    json['auth_token']
  end

  def valid_headers
    {
      "Authorization" => @auth_token,
      "Content-Type" => "application/json"
    }
  end
end
