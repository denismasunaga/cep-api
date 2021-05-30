module Ceps
  class ProcessRequestService
    def self.run(payload:)
      new(payload: payload).run
    end

    def run
      process_request
    end

    private

    def initialize(payload:)
      @payload = payload
    end

    def process_request
      return { errors: 'Payload vazio!' } if @payload.blank?

      return { errors: 'Digite um CEP para efetuar a pesquisa.' }, :unprocessable_entity if @payload.blank?

      search_result = Ceps::SearchService.run(cep: @payload)
      return search_result, :unprocessable_entity if search_result.key? :errors

      new_cep = Ceps::CreateService.run(payload: search_result)
      return new_cep, :unprocessable_entity if search_result.key? :errors

      CepWorker.perform_async(new_cep.attributes)
      response = Ceps::ResponseService.run(cep: new_cep)
      return response, :unprocessable_entity if search_result.key? :errors

      return response, :ok
    rescue StandardError => e
      { errors: e.message }
    end
  end
end
