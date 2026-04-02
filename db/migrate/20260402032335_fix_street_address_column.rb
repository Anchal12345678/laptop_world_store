class FixStreetAddressColumn < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :street_addres, :street_address
    add_column :users, :city, :string unless column_exists?(:users, :city)
    add_column :users, :postal_code, :string unless column_exists?(:users, :postal_code)
  end
end