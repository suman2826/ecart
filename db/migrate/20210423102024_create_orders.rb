class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :user
      t.string :invoice_number, null: false, unique: true
      t.timestamps
    end
  end
end
