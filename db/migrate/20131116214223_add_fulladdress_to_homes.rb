class AddFulladdressToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :fulladdress, :string
  end
end
