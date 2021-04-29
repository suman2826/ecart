class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def add_item(product_id:, quantity: 1)
    product = Product.find(product_id)

    order_item = order.items.find_or_initialize_by(
      product_id: product_id
    )

    order_item.price = product.price
    order_item.quantity = quantity

    order_item.save
  end
end
