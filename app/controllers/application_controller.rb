class ApplicationController < ActionController::API
  protected

  def authorize
    @user = Auth::AuthenticationService.run(payload: request_token)
    raise 'Usuário inexistente!' if @user.blank?

    @user
  rescue StandardError => e
    render json: { errors: e.message }, status: :forbidden
  end

  def request_token
    request.headers['Authorization'].try(:gsub, /^Bearer /, '')
  end
end
