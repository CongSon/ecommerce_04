class CreateRates < ActiveRecord::Migration[5.0]
  def change
    create_table :rates do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.float :point

      t.timestamps
    end
    add_index :rates, [:user_id, :product_id], unique: true
  end
end
