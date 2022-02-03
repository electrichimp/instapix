class AddCompleteToPrints < ActiveRecord::Migration[6.1]
  def change
    add_column :prints, :complete, :boolean, default: false
  end
end
