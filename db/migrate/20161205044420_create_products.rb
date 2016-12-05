class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :desciption
      t.float :price
      t.string :image
      t.integer :quantity
      t.float :rating
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :products, [:id, :category_id], unique: true
    add_index :products, :name, unique: true
  end
end
