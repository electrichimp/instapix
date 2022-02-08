class AddColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :instagram_auth_code, :string
  end
end
