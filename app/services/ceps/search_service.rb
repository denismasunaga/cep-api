module Ceps
  class SearchService
    require 'net/http'

    CEP_SEARCH_URL = 'https://viacep.com.br/ws/'.freeze

    def self.run(cep:)
      new(cep: cep).run
    end

    def run
      search_cep
    end

    private

    def initialize(cep:)
      @cep = cep
    end

    def search_cep
      return { errors: 'CEP em branco!' } if @cep.blank?

      uri = URI("#{CEP_SEARCH_URL}/#{@cep}/json/")
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new uri
        response = http.request(request)

        JSON.parse(response.body)
      end

    rescue StandardError
      { errors: 'Não foi possível efetuar a busca pelo CEP.' }
    end
  end
end
