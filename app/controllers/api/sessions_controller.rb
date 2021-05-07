module Api
  class SessionsController < ApplicationController
    skip_before_action :authenticate!

    def create
      user = User.where(
        email: params[:email]
      ).first

      return unauthorized! if user.blank?
      if user.confirmed?

        if user.valid_password?(params[:password])
          token = encode_token({id: user.id})

          render json: {user: {
                          id: user.id,
                          email: user.email,
                          name: user.name,
                          token: token
                        }}
        else
          unauthorized!
        end
      else
        render json: {status: "Please confirm you email first!!"}
      end
    end

    def unauthorized!
      render json: {success: false, error: 'Invalid Authentication'}, status: :unauthorized and return
    end
  end
end
