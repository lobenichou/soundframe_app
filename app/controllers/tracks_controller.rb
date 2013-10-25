class TracksController < ApplicationController

	def index
		@users = @client.get('/users', :q => params[:user], :limit => 10)
	end

	def show
		@id = params[:id]
		
		@search_tracks = @client.get('/users/'"#{@id}"'/tracks', :limit => 50 )


		@user = User.find_or_create_by_soundcloud_user_id({
        :soundcloud_user_id  => @id
      })


		@search_tracks.each do |search_track|
			@user.tracks.create(
					:soundcloud_track_id => search_track.id,
					:title => search_track.title , 
					:genre => search_track.genre, 
					:permalink_url => search_track.permalink_url, 
					:artwork_url => search_track.artwork_url)
		end
		@soundcloud_user = User.where(soundcloud_user_id: @id)
		@user_tracks = Track.where(user_id: @soundcloud_user[0][:id])
		render :show
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
					track = Track.find(@query["#{count}"][:track_id])
					track.latitude =  @lat
					track.longitude = @lng
					track.save
				end
				count += 1
			end

			gon.coordinates = {}
			gon.permalink_url = {}
			gon.track_title = {}
			gon.track_image = {}

			@all_tracks = Track.all

				@all_tracks.each do |track|
					unless track.latitude == nil
					gon.coordinates[track.id] = [track.latitude, track.longitude]
					gon.permalink_url[track.id] = track.permalink_url
					gon.track_title[track.id] = track.title
					gon.track_image[track.id] = track.artwork_url
					end

				end

			render :map
		end
		
end


