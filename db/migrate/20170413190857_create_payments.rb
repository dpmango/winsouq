class CreatePayments < ActiveRecord::Migration[5.0]
  def change
    create_table :payments do |t|
      t.references :shop, foreign_key: true
      t.string :icon
      t.string :image

      t.timestamps
    end
  end
end
