class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.validate_token!(token)
    end
    rescue Exception => e
      data = {}
      if e.is_a?(User::InvalidToken)
        data = {
          status: 'invalid_token',
          message: 'Invalid token'
        }
      elsif e.is_a?(User::ExpiredToken)
        data = {
          status: 'expired_token',
          message: 'Expired token'
        }
      end
      render json: data, status: :unauthorized
    end

  def current_user
    @current_user
  end
end
