module Jwt
  class JsonWebToken
    SECRET_KEY = ENV['DEVISE_JWT_SECRET_KEY']

    def self.encode(content)
      JWT.encode(content, SECRET_KEY)
    end

    def self.decode(token)
      decoded = JWT.decode(token, SECRET_KEY, true)[0]
      HashWithIndifferentAccess.new(decoded)
    rescue JWT::DecodeError, JWT::VerificationError
      {}
    end

    def expired?(content)
      return verify_exp if content['exp']
      return verify_iat if content['iat']

      false
    end

    private

    def verify_exp
      expires_at = Time.at(content['exp']).in_time_zone

      in_the_past?(expires_at)
    end

    def verify_iat
      expires_at = (Time.at(content['iat']).in_time_zone + ENV['TOKEN_EXPIRATION'])

      in_the_past?(expires_at)
    end

    def in_the_past?(time)
      time <= Time.current
    end
  end
end
