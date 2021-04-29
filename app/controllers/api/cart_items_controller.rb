module Api
    class CartItemsController < ApplicationController
      before_action :set_cart
      before_action :fetch_cart_items

      def index
        render json: @cart_items
      end

      def create
        add_quantity = params[:quantity].to_i
        product = @cart_items.where(product_id: params[:product_id])
        if add_quantity < 0
          render json: {status: "The product with negative quantity can't be added"} and return
        end
        if product.exists? 
          v = product.first.increment!(:quantity,add_quantity)
          render json: {status: "The quantity of this particular product is being increased"} and return
        else
          @cart_items.create(product_id: params[:product_id], quantity: params[:quantity])
        end
        render json: @cart_items   
      end
      
      def show
        product = @cart_items.where(id:params[:id])
        if product.exists?
          render json: product.first
        else
          render json: {status: "No product with this cart_id in the cart_items!!"}
        end
      end
      
      def destroy
        product = @cart_items.where(id: params[:id])
        if product.exists?
          product.first.destroy
          render json: {status: "The product is being deleted from the cart_items"}
        else
          render json: {status: "No product with this cart_id in the cart_items!!"}
        end
      end

      def update
        add_quantity = params[:quantity].to_i
        if add_quantity < 0
          render json: {status: "The product with negative quantity can't be updated!!"} and return
        end
        product = @cart_items.where(id: params[:id])
        if product.exists?
          product.first.update( quantity: params[:quantity])
          render json: product.first
        else
          render json: {status: "No product with this cart_id in the cart_items!!"}
        end
      end

      private

      def set_cart
        if current_user.cart
          return 
        else 
          cart = Cart.create(user_id: current_user.id)
          cart.cart_items = []
          render json: cart.cart_items
        end
      end

      def fetch_cart_items
        @cart_items = current_user.cart.cart_items
      end

     
  end
end
  