class AddDescriptionToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :description, :text
  end
end
