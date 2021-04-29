class CreateOrderItems < ActiveRecord::Migration[6.0]
  def change
    create_table :order_items do |t|
      t.references :order
      t.references :product
      t.integer :quantity
      t.string :product_name
      t.decimal :product_price, precision: 10, scale: 2
      t.timestamps
    end
  end
end
