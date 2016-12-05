class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.integer :status
      t.float :total_pay
      t.references :user, foreign_key: true
      t.string :shipping_address
      t.string :phone
      t.string :bill_code

      t.timestamps
    end
    add_index :orders, [:id, :user_id], unique: true
  end
end
