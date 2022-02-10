class CreatePrints < ActiveRecord::Migration[6.1]
  def change
    create_table :prints do |t|
      t.string :title
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.float :purchase_price

      t.timestamps
    end
  end
end
