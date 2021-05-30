module Ceps
  class CreateService
    def self.run(payload:)
      new(payload: payload).run
    end

    def run
      create_cep
    end

    private

    def initialize(payload:)
      @payload = payload
    end

    def create_cep
      return { errors: 'Payload vazio!' } if @payload.blank?

      Cep.new(
        cep: @payload['cep'],
        logradouro: @payload['logradouro'],
        complemento: @payload['complemento'],
        bairro: @payload['bairro'],
        cidade: @payload['localidade'],
        uf: @payload['uf']
      )
    end
  end
end
