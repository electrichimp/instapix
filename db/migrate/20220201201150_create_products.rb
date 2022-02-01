class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category
      t.float :base_price
      t.integer :photo_count

      t.timestamps
    end
  end
end
