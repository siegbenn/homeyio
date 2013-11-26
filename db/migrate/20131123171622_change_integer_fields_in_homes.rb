class ChangeIntegerFieldsInHomes < ActiveRecord::Migration
  def change
  	remove_column :homes, :price
  	remove_column :homes, :beds
  	remove_column :homes, :baths
  	remove_column :homes, :house_size
  	remove_column :homes, :lot_size

  	add_column :homes, :price, :string
  	add_column :homes, :beds, :float
  	add_column :homes, :baths, :float
  	add_column :homes, :house_size, :float
  	add_column :homes, :lot_size, :float
  end
end
