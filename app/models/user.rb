class User < ApplicationRecord
  has_one :cart
  has_many :cart_items, through: :cart

  has_many :orders
  has_many :order_items, through: :orders
  
  after_create :create_cart

  def create_cart
    return if cart_exists?
    Cart.create(user: self)
  end

  def cart_exists?
    cart.present?
  end
end
