module TracksHelper

  def setup_map
    gon.coordinates = {}
    gon.permalink_url = {}
    gon.track_title = {}
    gon.track_image = {}

    all_tracks = Track.all

    all_tracks.each do |track|
      unless track.latitude == nil
        gon.coordinates[track.id] = [track.latitude, track.longitude]
        gon.permalink_url[track.id] = track.permalink_url
        gon.track_title[track.id] = track.title
        gon.track_image[track.id] = track.artwork_url
      end

    end
  end

end
