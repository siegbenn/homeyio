class RemoveFieldsFromHomes < ActiveRecord::Migration
  def change
  	remove_column :homes, :city
  	remove_column :homes, :state
  	remove_column :homes, :zip
  	remove_column :homes, :fulladdress
  end
end
