module Authenticable
  class WebToken
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    def self.encode(payload, exp = 30.minutes.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, algoritm = 'HS256')
    end

    def self.decode(token)
      JWT.decode(token, SECRET_KEY, true, options={algoritm: 'HS256'})
    end
  end
end
