class CartItem < ApplicationRecord
  # attr_reader :items

  # def initialize 
  #   binding.pry
  #   @items = []
  # end

  MIN_QUANTITY = 1
  belongs_to :cart
  belongs_to :product

  validate :validate_quantity
  # validate :validate_product, :on => :create 

  def validate_quantity
    if self.quantity < MIN_QUANTITY
      self.errors.add(:quantity, "should be more than 0")
    end
  end

  # def validate_product
  #   binding.pry
  #   current_item = @items.where{ |item| item.product_id == product_id}
  #   if current_item
  #     current_item.increment!(quantity, self.quantity)
  #   else
  #     cart_item = CartItem.new(product_id: self.product_id, quantity: self.quantity)
      
  #     @items << cart_item
  #   end
  # end

  def format
    {
      id: id,
      created_at: created_at,
      quantity: quantity,
      price: quantity * product.price,
      product: {
        id: product.id,
        name: product.name,
        price: product.price
      }
    }
  end

end
