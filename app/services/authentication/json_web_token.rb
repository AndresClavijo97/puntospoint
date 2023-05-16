module Authentication
  # service for user authentication using JWT
  class JsonWebToken
    extend self

    EXPIRATION = 60.minutes

    def encode(payload)
      expiration = EXPIRATION.from_now.to_i
      payload_with_expiration = payload.merge(exp: expiration)
      Jwt.encode(payload_with_expiration, Rails.application.credentials.secret_key_base)
    end

    def decode(token)
      Jwt.decode(token, Rails.application.credentials.secret_key_base).first
    end
  end
end
