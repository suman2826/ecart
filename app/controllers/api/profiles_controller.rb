module Api
  class ProfilesController < ApplicationController
    def show
      data = current_user.attributes.symbolize_keys
      data.delete(:encrypted_password)
      render json: data
    end
  end
end
