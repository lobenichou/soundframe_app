class Track < ActiveRecord::Base
  attr_accessible :artwork_url, :genre, :latitude, :longitude, :permalink_url, :soundcloud_track_id, :title, :user_id

	belongs_to :authors

  validates :soundcloud_track_id, :uniqueness => true


  def self.find_and_save_lat_lons(query)
    query.each do |item, location|
      location[:input].gsub!(" ", '+')
      location[:input].gsub!(",", "+")
      request = Typhoeus.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{location[:input]}&sensor=true")
      hash = JSON.parse(request.body)
      track = Track.find_or_create_by_soundcloud_track_id(location["track_id"])
      track.save_lat_lon(hash["results"]) unless hash["results"].empty?
    end
  end

  def save_lat_lon(result)
    lat = result[0]["geometry"]["location"]["lat"]
    lng = result[0]["geometry"]["location"]["lng"]
    self.update_attributes(latitude: lat, longitude: lng)
  end

end
