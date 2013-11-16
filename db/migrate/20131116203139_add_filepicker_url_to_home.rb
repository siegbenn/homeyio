class AddFilepickerUrlToHome < ActiveRecord::Migration
  def change
  	add_column :homes, :filepicker_url, :string
  end
end
