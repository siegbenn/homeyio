class AddFullAddressToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :full_address, :string
  end
end
