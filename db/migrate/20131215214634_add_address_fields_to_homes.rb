class AddAddressFieldsToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :address_2, :string
  	add_column :homes, :city, :string
  	add_column :homes, :state, :string
  	add_column :homes, :zip, :integer
  end
end
