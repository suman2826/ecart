class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :order_items 

  def formats
    {
      category_id: category_id,
      created_at: created_at,
      product: {
        id: id,
        name: name,
        price: price
      }
    }
  end
end

