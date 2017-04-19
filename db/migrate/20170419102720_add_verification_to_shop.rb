class AddVerificationToShop < ActiveRecord::Migration[5.0]
  def change
    add_column :shops, :verified, :boolean, default: false
  end
end
