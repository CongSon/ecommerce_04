class CreatePromotions < ActiveRecord::Migration[5.0]
  def change
    create_table :promotions do |t|
      t.references :product, foreign_key: true
      t.float :sale
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
    add_index :promotions, [:id, :product_id], unique: true
  end
end
