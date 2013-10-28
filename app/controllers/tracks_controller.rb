class TracksController < ApplicationController
	include TracksHelper

	def index
		query = params[:user]

		if query.empty?
			render :error
		else
		@users = @client.get('/users', :q => query, :limit => 10)
		end

	end

	def show
		id = params[:id]
		@search_tracks = @client.get('/users/'"#{id}"'/tracks', :limit => 50 )

		@user = User.find_or_create_by_soundcloud_user_id({
		      :soundcloud_user_id  => id,
		      :soundcloud_username => params[:username]
	  		})


		@search_tracks.each do |search_track|
			@user.tracks.create(
				:soundcloud_track_id => search_track.id,
				:title => search_track.title ,
				:genre => search_track.genre,
				:permalink_url => search_track.permalink_url,
				:artwork_url => search_track.artwork_url)
			end
		end


	def create
	 	query = params[:location]

	 	Track.find_and_save_lat_lons(query)
	 		#Makes call to google api and saves lat lons to database


		setup_map
			#sets up array of coordinates for map
		render :map
	end

end


