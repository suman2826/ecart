class Category < ApplicationRecord
  has_many :products

  def format
    result = {}
    data = []
    self.products.each do |product|
      data << product.format
    end

    result[:items] = data
    return result
  end
end
