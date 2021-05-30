module Api
  module V1
    class CepsController < ApplicationController
      before_action :authorize

      respond_to :json

      def search_cep
        render json: { errors: 'Digite um CEP para efetuar a pesquisa.' }, status: :unprocessable_entity if params[:cep].blank?

        search_result = Ceps::SearchService.run(cep: params[:cep])
        render json: search_result, status: :unprocessable_entity if search_result.key? 'errors'

        persisted_cep = Ceps::PersistService.run(payload: search_result)
        render json: persisted_cep, status: :unprocessable_entity if search_result.key? 'errors'

        result = Ceps::ResponseService.run(cep: persisted_cep)

        render json: result, status: :ok
      end
    end
  end
end
