class ApplicationController < ActionController::API
  protected

  def authorize
    Auth::AuthenticationService.run(payload: request_token)
  rescue StandardError => e
    render json: { errors: e.message }, status: :forbidden
  end

  def request_token
    request.headers['Authorization'].try(:gsub, /^Bearer /, '')
  end
end
