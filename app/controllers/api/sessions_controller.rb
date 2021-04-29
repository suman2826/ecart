module Api
  class SessionsController < ApplicationController
    def create
      user = User.where(
        email: params[:email],
        password: params[:password]
      ).first

      if user.present?
        render json: {user: {
                        id: user.id,
                        email: user.email,
                        name: user.name
                      }}
      else
        render json: {status: 401, error: true, message: 'Unauthorized'}
      end
    end
  end
end
