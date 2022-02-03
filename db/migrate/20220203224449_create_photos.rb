class CreatePhotos < ActiveRecord::Migration[6.1]
  def change
    create_table :photos do |t|
      t.references :print
      t.string :caption

      t.timestamps
    end
  end
end
