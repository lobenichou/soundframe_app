module ProjectsHelper

  def find_and_save_lat_lons(track, project, location)
    project.tracks << track
    proj_tr = ProjectTrack.find(:first, :conditions => {project_id: project.id, track_id: track.id})
    location.gsub!(" ", '+')
    location.gsub!(",", "+")
    request = Typhoeus.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{location}&sensor=true")
    hash = JSON.parse(request.body)
    proj_tr.save_lat_lon(hash["results"]) unless hash["results"].empty?
  end

  def setup_map(project)
    proj_trs = ProjectTrack.find(:all, :conditions => {project_id: project.id})
    tracks = project.tracks
    gon.coordinates = {}
    gon.soundcloud_track_id = {}
    gon.permalink_url = {}
    gon.track_title = {}
    gon.track_image = {}
    mapped_tracks = []


    proj_trs.each do |proj_tr|
      unless proj_tr.latitude == nil
        gon.coordinates[proj_tr.track_id] = [proj_tr.latitude, proj_tr.longitude]
        mapped_tracks << tracks.find(proj_tr.track_id)
        mapped_tracks.each do |mapped_track|
          gon.permalink_url[proj_tr.track_id] = mapped_track.permalink_url
          gon.soundcloud_track_id[proj_tr.track_id] = mapped_track.soundcloud_track_id
          gon.track_title[proj_tr.track_id] = mapped_track.title
          gon.track_image[proj_tr.track_id] = mapped_track.artwork_url
        end
      end
    end
  end

end
