module Api
    class UsersController < ApplicationController
        skip_before_action :authenticate!
        def create
            user = User.new(
                name:params[:name],
                email:params[:email],
                password:params[:password]
            )
            
            # binding.pry
            if user.save
                render json:{
                    status:"User created",
                    name:user.name,
                    email:user.email    
                }, status: :ok
            else
                render json:{
                    status: false,
                    error: "Unsuccessful"
                }, status: :unauthorized
            end
        end
    end
end

