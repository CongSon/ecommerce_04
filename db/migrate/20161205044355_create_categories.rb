class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :depth, null: false, default: 0
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
