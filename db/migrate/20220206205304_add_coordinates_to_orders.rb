class AddCoordinatesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :latitude, :float
    add_column :orders, :longitude, :float
  end
end
