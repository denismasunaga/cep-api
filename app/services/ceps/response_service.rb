module Ceps
  class ResponseService
    def self.run(cep:)
      new(cep: cep).run
    end

    def run
      cep_response
    end

    private

    def initialize(cep:)
      @cep = cep
    end

    def cep_response
      return { errors: 'Cep vazio!' } if @cep.blank?

      decorated_cep = @cep.decorate

      {
        endereco: decorated_cep.logradouro,
        bairro: decorated_cep.bairro,
        cidade: decorated_cep.cidade,
        uf: decorated_cep.uf,
        endereco_completo: decorated_cep.full_address
      }
    end
  end
end
