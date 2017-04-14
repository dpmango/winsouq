class CreateSocials < ActiveRecord::Migration[5.0]
  def change
    create_table :socials do |t|
      t.references :shop, foreign_key: true
      t.string :link
      t.string :image

      t.timestamps
    end
  end
end
