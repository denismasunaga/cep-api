module Api
  module V1
    class CepsController < ApplicationController
      before_action :authorize

      def search_cep
        result, status = Ceps::ProcessRequestService.run(payload: params[:cep])
        render json: result, status: status
      end
    end
  end
end
