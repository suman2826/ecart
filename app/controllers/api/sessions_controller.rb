module Api
  class SessionsController < ApplicationController
    skip_before_action :authenticate!

    def create
      user = User.where(
        email: params[:email]
      ).first

      return unauthorized! if user.blank?

      if user.valid_password?(params[:password])
        token = user.generate_token!

        render json: {user: {
                        id: user.id,
                        email: user.email,
                        name: user.name,
                        token: token
                      }}
      else
        unauthorized!
      end
    end

    def unauthorized!
      render json: {success: false, error: 'Invalid Authentication'}, status: :unauthorized and return
    end
  end
end
