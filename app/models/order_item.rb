class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def format
    {
      id: id,
      quantity: quantity,
      price: quantity * product_price,
      product: {
        id: product_id,
        name: product_name,
        price: product_price
      }
    }
  end
end
