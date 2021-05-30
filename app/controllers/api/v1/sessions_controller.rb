module Api
  module V1
    class SessionsController < ApplicationController
      respond_to :json

      def create
        user = User.find_by(email: session_params[:email])
        render json: { errors: 'E-mail ou senha inválidos' }, status: :unprocessable_entity if user.blank?

        jwt = Auth::SessionTokenService.run(user: user)
        render json: { token: jwt }, status: :ok
      end

      private

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end
  end
end
