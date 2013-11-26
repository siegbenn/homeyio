class AddFieldsToHome < ActiveRecord::Migration
  def change
  	add_column :homes, :price, :integer
  	add_column :homes, :beds, :integer
  	add_column :homes, :baths, :integer
  	add_column :homes, :house_size, :integer
  	add_column :homes, :lot_size, :integer
  	add_column :homes, :year, :integer
  end
end
