class CreateOrderDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :order_details do |t|
      t.references :product, foreign_key: true
      t.integer :quantity
      t.references :order, foreign_key: true
      t.float :price
      t.string :product_name

      t.timestamps
    end
    add_index :order_details, [:id, :product_id], unique: true
  end
end
