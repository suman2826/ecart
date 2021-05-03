class User < ApplicationRecord
  has_one :cart
  has_many :cart_items, through: :cart

  has_many :orders
  has_many :order_items, through: :orders
  
  # after_create :create_cart

  # def creation_of_cart
  #   return if cart_exists?
  #   create_cart
  # end

  # def cart_exists?
  #   cart.present?
  # end

  def create_order!
    cart_items = self.cart_items.includes(:product)
    order = self.orders.new

    if cart_items.blank?
      order.errors.add(:cart,"No items in the cart")
      return order
    end

    order.save
    cart_items.each do |cart_item|
      order.order_items.create(
        product_id: cart_item.product_id,
        quantity: cart_item.quantity,
        product_name: cart_item.product.name,
        product_price: cart_item.product.price
      )
      cart_item.destroy
    end
    return order
  end
end
