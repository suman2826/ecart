module Api
    class OrdersController < ApplicationController
        
        def index
            orders = current_user.orders.includes(:order_items)
            data = []
            orders.each do |order|
                data << order.format
            end
            render json: data
        end

        def create
            order = current_user.create_order!
            if order.errors.blank?
                render json: {
                    success: true,
                    order: order.format
                }, status: :ok
            else
                render json: {
                    success: false,
                    errors: order.errors
                }, status: :bad_request
            end  
        end

        def show
            particular_order = current_user.orders.where(id:params[:id]).first
            if particular_order
                render json: particular_order.order_items
            else
                render json: {success: false, error: "Not found"},
                        status: :not_found and return
            end
        end
    end
  end
  