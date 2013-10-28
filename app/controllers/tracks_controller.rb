class TracksController < ApplicationController
	include TracksHelper

def index
		@users = @client.get('/users', :q => params[:user], :limit => 10)
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

<<<<<<< HEAD

	end

	def create
			response = []
		 	@query = params[:location]

		 	@query.each do |item, location|
		 			location[:input].gsub!(" ", '+')
		 			location[:input].gsub!(",", "+")
					request = Typhoeus.get("http://maps.googleapis.com/maps/api/geocode/json?address=#{location[:input]}&sensor=true")
					result_hash = JSON.parse(request.body)
					response << result_hash
			end



			count = 0
			response.each do |hash|
				unless hash["results"] == []
					@lat = hash["results"][0]["geometry"]["location"]["lat"]
					@lng = hash["results"][0]["geometry"]["location"]["lng"]


					track = Track.find_or_create_by_soundcloud_track_id(@query[count.to_s]["track_id"])

					track.latitude =  @lat
					track.longitude = @lng
					track.save

				end
				count += 1
			end
=======
	end 
		
	def create
	 	query = params[:location]

	 	Track.find_and_save_lat_lons(query)
	 		#Makes call to google api and saves lat lons to database
>>>>>>> 7403f2981a28fe28d501c9da18d1a51c69949aa0

		setup_map
			#sets up array of coordinates for map
		render :map
	end

<<<<<<< HEAD
			render :map
		end

=======
>>>>>>> 7403f2981a28fe28d501c9da18d1a51c69949aa0
end


