class CreateSuggestedProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :suggested_products do |t|
      t.string :name
      t.text :description
      t.integer :status
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :suggested_products, [:id, :user_id], unique: true
  end
end
