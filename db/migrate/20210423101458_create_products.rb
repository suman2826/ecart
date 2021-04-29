class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    return if table_exists?(:products)
    
    create_table :products do |t|
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2
      t.references :category
      t.timestamps
    end 

  end
end
