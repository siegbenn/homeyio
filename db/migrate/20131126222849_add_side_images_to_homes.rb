class AddSideImagesToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :image_side_top, :string
  	add_column :homes, :image_side_bottom, :string
  end
end
