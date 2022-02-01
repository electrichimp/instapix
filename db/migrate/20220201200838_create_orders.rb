class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :shipping_address
      t.references :user, null: false, foreign_key: true
      t.integer :state
      t.float :total_price
      t.date :purchase_date

      t.timestamps
    end
  end
end
