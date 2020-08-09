module WebToken
  class << self
    SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

    def basic_decode(token)
      return if token.blank?

      Base64.decode64(token).split(':')
    end

    def encode(payload, exp = 30.minutes.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, algoritm = 'HS256')
    end

    def decode(token)
      JWT.decode(token, SECRET_KEY, true, options={algoritm: 'HS256'})
    rescue StandardError
      :invalid_credentials
    end
  end
end
