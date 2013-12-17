class TracksController < ApplicationController
	include TracksHelper

	before_filter :signed_in_user
  before_filter :correct_user, only: [:show, :create]

	def index
	end

	def show

		# id = params[:id]
		# @search_tracks = @client.get('/users/'"#{id}"'/tracks', :limit => 50 )

		# @author = Author.find_or_create_by_soundcloud_user_id({
		#       :soundcloud_user_id  => id,
		#       :soundcloud_username => params[:username]
	 #  		})


		# @search_tracks.each do |search_track|
		# 	@author.tracks.create(
		# 		:soundcloud_track_id => search_track.id,
		# 		:title => search_track.title ,
		# 		:genre => search_track.genre,
		# 		:permalink_url => search_track.permalink_url,
		# 		:artwork_url => search_track.artwork_url)
		# 	end
		end


	def create
		track = params[:track]

		existing_track = @user.library.tracks.find_by_soundcloud_track_id(track[:id])

		if existing_track
			render json: {track: track, text: "This track is already in your library."}, status: 201
		else
		@user.library.tracks.create(
				:soundcloud_track_id => track[:id],
				:title => track[:title] ,
				:genre => track[:genre],
				:permalink_url => track[:permalink_url],
				:artwork_url => track[:artwork_url])
		render json: {track: track, text: "Track was saved!"}, status: 201
	end

	 # 	query = params[:location]

	 # 	Track.find_and_save_lat_lons(query)
	 # 		#Makes call to google api and saves lat lons to database


		# setup_map
		# 	#sets up array of coordinates for map
		# render :map
	end

	private

	 def signed_in_user
    unless signed_in?
      store_location
      flash[:notice] = "Please sign in."
      redirect_to signin_url
    end
  end

  def correct_user
    @user = User.find(params[:user_id])
    redirect_to(root_url) unless current_user?(@user)
  end

end


