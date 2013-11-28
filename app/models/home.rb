class Home < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode, :if => :address_changed?
	belongs_to :user
	mount_uploader :image_main, ImageUploader
	mount_uploader :image_side_top, ImageUploader
end
