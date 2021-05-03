class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items

  before_create :assign_invoice

  def assign_invoice
    self.invoice_number = random_string
  end

  def random_string
    (0...8).map {(65 + rand(26)).chr }.join + Time.now.to_f.to_s.gsub('.','')
  end

  def format
    result = {
      id: id,
      invoice_number: invoice_number,
      created_at: created_at
    }
    data = []
    self.order_items.each do |order_item|
      data << order_item.format
    end

    result[:items] = data
    return result
  end
end
