class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  JWT_SECRET_KEY = Rails.application.secrets.secret_key_base
  JWT_ALGORITHM = 'HS512'

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      payload = decode_token(token)
      @current_user = User.find payload['id']
    end

    rescue JWT::ExpiredSignature
    data = {
      status: 'expired_token',
      message: 'Expired token'
    }

    render json: data, status: :unauthorized and return
  rescue JWT::ImmatureSignature, JWT::DecodeError
    data = {
      status: 'invalid_token',
      message: 'invalidtoken'
    }

    render json: data, status: :unauthorized and return
  end

  def current_user
    @current_user
  end

  def encode_token(payload, exp = 30.days.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, JWT_SECRET_KEY, JWT_ALGORITHM)
  end
  
  def decode_token(token)
    JWT.decode(token, JWT_SECRET_KEY, true, algorithm: JWT_ALGORITHM).first
  end
end
