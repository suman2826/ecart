class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate!

  def authenticate!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = User.where(id: token).first
      @current_user.present?
    end
  end

  def current_user
    @current_user
  end
end
