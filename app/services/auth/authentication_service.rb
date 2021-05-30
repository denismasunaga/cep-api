module Auth
  class AuthenticationService
    def self.run(payload:)
      new(payload: payload).run
    end

    def run
      authenticate
    end

    private

    def initialize(payload:)
      @decoded_payload = decoded_payload(payload: payload)
    end

    def authenticate
      User.find(@decoded_payload.fetch(:id))
    rescue StandardError
      raise 'O token enviado não é válido ou expirou. Efetue um novo login e tente novamente.'
    end

    def decoded_payload(payload:)
      Jwt::JsonWebToken.decode(payload).deep_symbolize_keys
    end
  end
end
