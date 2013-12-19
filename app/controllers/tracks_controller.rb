class TracksController < ApplicationController
	include TracksHelper

	before_filter :signed_in_user
  before_filter :correct_user, only: [:show, :create]

  def create
    track = params[:track]

    existing_track = @user.library.tracks.find_by_soundcloud_track_id(track[:id])

    if existing_track
     render json: {track: track, text: "This track is already in your library."}, status: 201
   else
    @user.library.tracks.create(
      :soundcloud_track_id => track[:id],
      :title => track[:title] ,
      :artist => track[:user][:username],
      :genre => track[:genre],
      :permalink_url => track[:permalink_url],
      :artwork_url => track[:artwork_url])
    render json: {track: track, text: "Track was saved!"}, status: 201
  end
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


