class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :image
      t.string :description
      t.float :price
      t.string :name
      t.references :shop, index: true, foreign_key: true

      t.timestamps
    end
  end
end
