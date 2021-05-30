module Auth
  class SessionTokenService
    def self.run(user:)
      new(user: user).run
    end

    def run
      create_session_token
    end

    private

    def initialize(user:)
      @user = user
    end

    def create_session_token
      Jwt::JsonWebToken.encode(
        {
          id: @user.id,
          exp: (Time.at(Time.now).in_time_zone.to_i + ENV['TOKEN_EXPIRATION'].to_i)
        }
      )
    end
  end
end
