class Track < ActiveRecord::Base
  attr_accessible :artwork_url, :genre, :latitude, :longitude, :permalink_url, :soundcloud_track_id, :title, :user_id
	
	belongs_to :user

  validates :soundcloud_track_id, :uniqueness => true
  
end
