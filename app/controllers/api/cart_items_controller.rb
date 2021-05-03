module Api
    class CartItemsController < ApplicationController
      before_action :set_cart
      before_action :fetch_cart_item, only: [:update, :destroy, :show]
      before_action :fetch_cart_items, only: [:create, :index]

      def index
        items = @cart_items.includes(:product)
        data = []
        items.each do |cart_item|
          data << cart_item.format
        end
        render json: data
      end

      def create
        add_quantity = params[:quantity].to_i
        product = @cart_items.where(product_id: params[:product_id])
        if product.blank? 
          cart_item = @cart_items.new(product_id: params[:product_id], quantity: params[:quantity]) 
        else
          product.first.increment!(:quantity,add_quantity)
          render json: {
            status: true,
            message: "The value is incremented "
          } and return
        end
        
        if cart_item.save
          # @items << cart_item
          render json: {success: true,
            cart_item: cart_item.format
          }, status: :ok
        else
          render json: {
              success: false,
              errors: cart_item.errors
            }, status: :bad_request
        end
      end
      
      def show
        render json: @cart_item.format
      end

      def destroy
        @cart_item.destroy
        render json: {
               success: true,
               cart_item: @cart_item.format
             }
      end

      def update
        @cart_item.update( quantity: params[:quantity])
        render json: {
               success: true,
               cart_item: @cart_item.format
             }
      end

      private
      def set_cart
        if current_user.cart
          return 
        else 
          cart = Cart.create(user_id: current_user.id)
          cart.cart_items = []
          render json: cart.cart_items and return
        end
      end

      def fetch_cart_item
        @cart_item = current_user.cart_items.find params[:id]
        rescue ActiveRecord::RecordNotFound
          render json: {success: false, error: "Not found"},
            status: :not_found and return
      end

      def fetch_cart_items
        @cart_items = current_user.cart_items
      end

  end
end
  