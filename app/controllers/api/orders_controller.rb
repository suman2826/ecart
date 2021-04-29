module Api
    class OrdersController < ApplicationController
        def index
            user_orders = Order.all.where(user_id: current_user.id)
            render json: user_orders

        end

        def create
            items = current_user.cart.cart_items
            product = []
            items.each do |item|
                product_id = item.product_id
                product << Product.find(product_id)    
            end
            if items.exists?
                a = Order.create(user_id: current_user.id, invoice_number: rand(50090..10005656).to_s, total: 0)
                order_items = []
                total_value = 0.00
                items.zip(product).each do |item, p|
                    order_items << {product_id: item.product_id, quantity: item.quantity, product_name: p.name, product_price: p.price}
                    total_value += item.quantity*p.price
                end 
                a.update(total: total_value)
                a.order_items.create(order_items)
                current_user.cart.cart_items = []
                render json: {status: "The order is placed!!"}
            else
                render json: {status: "No items in the cart!!"}

            end
            
            
        end

        def show
            user_orders = Order.all.where(user_id: current_user.id)
            particular_order = user_orders.where(id:params[:id]).first
            if particular_order
                render json: particular_order.order_items
            else
                render json: {status: "No order"}
            end
        end

    end
  end
  