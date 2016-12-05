class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
    add_index :categories, :name, unique: true
  end
end
