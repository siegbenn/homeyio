class AddUserIdToHomes < ActiveRecord::Migration
  def change
  	add_column :homes, :user_id, :integer
  end
end
