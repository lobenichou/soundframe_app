module ProjectsHelper

  def find_and_save_lat_lons(track, project, location)
    unless project.tracks.include? track
      project.tracks << track
    end
    proj_tr = ProjectTrack.find(:first, :conditions => {project_id: project.id, track_id: track.id})
    location.gsub!(" ", '+')
    location.gsub!(",", "+")
    request = Typhoeus.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{location}&sensor=true")
    hash = JSON.parse(request.body)
    updated_proj_tr = proj_tr.save_lat_lon(hash["results"]) unless hash["results"].empty?
    if updated_proj_tr
      render json: {project: project.id, track: track.soundcloud_track_id, text: "Track was saved to map!"}, status: 201
    else
      render json: {errors: updated_proj_tr.errors.full_messages}, status: 422
    end
  end

  def add_image(track, project, image)
    unless project.tracks.include? track
      project.tracks << track
    end
    proj_tr = ProjectTrack.find(:first, :conditions => {project_id: project.id, track_id: track.id})
    updated_proj_tr = proj_tr.update_attributes(image: image)
    if updated_proj_tr
      render json: {track: track.soundcloud_track_id, text: "Image was associated to track!"}, status: 201
    else
      render json: {errors: updated_proj_tr.errors.full_messages}, status: 422
    end
  end

  def setup_map(project)
    proj_trs = ProjectTrack.find(:all, :conditions => {project_id: project.id})
    tracks = project.tracks
    gon.coordinates = {}
    gon.soundcloud_track_id = {}
    gon.permalink_url = {}
    gon.track_title = {}
    gon.track_image = {}
    gon.user_image_thumb = {}
    gon.user_image_medium = {}
    mapped_tracks = []


    proj_trs.each do |proj_tr|
      unless proj_tr.latitude == nil
        gon.coordinates[proj_tr.track_id] = [proj_tr.latitude, proj_tr.longitude]
        gon.user_image_thumb[proj_tr.track_id] = [proj_tr.image.thumb.url]
        gon.user_image_medium[proj_tr.track_id] = [proj_tr.image.medium.url]
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
