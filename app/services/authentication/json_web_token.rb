module Authentication
  # service for user authentication using JWT
  class JsonWebToken
    EXPIRATION = 60.minutes

    def self.encode(payload)
      expiration = EXPIRATION.from_now.to_i
      payload_with_expiration = payload.merge(exp: expiration)
      JWT.encode(payload_with_expiration, Rails.application.credentials.secret_key_base)
    end

    def self.decode(token)
      JWT.decode(token, Rails.application.credentials.secret_key_base).first
    end
  end
end
