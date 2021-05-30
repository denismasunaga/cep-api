module Ceps
  class CreateService
    def self.run(payload:, user:)
      new(payload: payload, user: user).run
    end

    def run
      create_cep
    end

    private

    def initialize(payload:, user:)
      @payload = payload
      @user = user
    end

    def create_cep
      return { errors: 'Payload vazio!' } if @payload.blank?

      Cep.new(
        cep: @payload['cep'],
        logradouro: @payload['logradouro'],
        complemento: @payload['complemento'],
        bairro: @payload['bairro'],
        cidade: @payload['localidade'],
        uf: @payload['uf'],
        user: @user
      )
    end
  end
end
