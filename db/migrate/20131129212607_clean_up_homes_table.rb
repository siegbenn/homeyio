class CleanUpHomesTable < ActiveRecord::Migration
  def change
  	remove_column :homes, :filepicker_url
  	remove_column :homes, :image_main
  	remove_column :homes, :image_side_top
  	remove_column :homes, :image_side_bottom
  	add_column :homes, :image_inside, :string
  	add_column :homes, :image_outside, :string
  end
end
