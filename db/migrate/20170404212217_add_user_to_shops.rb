class AddUserToShops < ActiveRecord::Migration[5.0]
  def change
    add_reference :shops, :user, foreign_key: true
    add_reference :shops, :category, index: true, foreign_key: true
  end
end
