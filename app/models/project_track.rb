class ProjectTrack < ActiveRecord::Base
  attr_accessible :project_id, :text, :track_id, :latitude, :longitude, :image, :imageDescription
  mount_uploader :image, ImageUploader
  belongs_to :project
  belongs_to :track

   def save_lat_lon(result)
    lat = result[0]["geometry"]["location"]["lat"]
    lng = result[0]["geometry"]["location"]["lng"]
    self.update_attributes(latitude: lat, longitude: lng)
  end

end
