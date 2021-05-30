module Ceps
  class PersistService
    def self.run(payload:)
      new(payload: payload).run
    end

    def run
      persist_cep
    end

    private

    def initialize(payload:)
      @payload = payload
    end

    def persist_cep
      return { errors: 'Payload vazio!' } if @payload.blank?

      Cep.create!(
        cep: @payload['cep'],
        logradouro: @payload['logradouro'],
        complemento: @payload['complemento'],
        bairro: @payload['bairro'],
        cidade: @payload['localidade'],
        uf: @payload['uf']
      )

    rescue StandardError
      { errors: 'Não foi possível salvar o CPF.' }
    end
  end
end
