class AddIconToSocial < ActiveRecord::Migration[5.0]
  def change
    add_column :socials, :icon, :string
  end
end
