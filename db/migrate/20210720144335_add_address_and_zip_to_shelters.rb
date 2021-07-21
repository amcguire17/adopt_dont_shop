class AddAddressAndZipToShelters < ActiveRecord::Migration[5.2]
  def change
    add_column :shelters, :address, :string
    add_column :shelters, :zip_code, :string
  end
end
