class AddRegFiledsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :type, :string
    add_column :users, :username, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthday, :string
    add_column :users, :city, :string
  end
end
