class User < ApplicationRecord

  InvalidToken = Class.new(StandardError)
  ExpiredToken = Class.new(StandardError)
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable
  # , :registerable, :recoverable, :rememberable, :validatable
  has_one :cart
  has_many :cart_items, through: :cart

  has_many :orders
  has_many :order_items, through: :orders
  
  after_create :create_cart

  validates :email, uniqueness: true, presence: true

  def generate_token!
    return token if token.present?
    token = SecureRandom.urlsafe_base64(100)
    self.update(token: token, token_created_at: Time.now)
    token
  end

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

  class << self
    def validate_token!(token)
      raise InvalidToken if token.blank?
      user = self.where(token: token).first
      raise InvalidToken if user.blank?
      if (Time.now - user.token_created_at) > 5.hours
        raise ExpiredToken
      end
      user
    end
  end
end
