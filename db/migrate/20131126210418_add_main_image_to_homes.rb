class AddMainImageToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :image_main, :string
  end
end
