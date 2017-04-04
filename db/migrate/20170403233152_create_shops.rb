class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :title
      t.string :image
      t.text :description
      t.string :location
      t.string :email
      t.string :phone
      t.string :phone_2
      t.string :contacts

      t.timestamps
    end
  end
end
