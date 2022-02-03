class AddColumnsToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :description, :string
    add_column :products, :details, :string
  end
end
