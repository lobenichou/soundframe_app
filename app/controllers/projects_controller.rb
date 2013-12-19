class ProjectsController < ApplicationController
  include ProjectsHelper
  before_filter :signed_in_user
  before_filter :correct_user,  only: [:create]

def new
  @tracks = current_user.library.tracks.all
end

def create
  project = @user.projects.create(params[:project])
  redirect_to "/projects/#{project.id}/edit"
end

def edit
  @tracks = current_user.library.tracks.all
  @project = Project.find(params[:id])
end

def update
  track = current_user.library.tracks.find_by_soundcloud_track_id(params[:track])
  project = current_user.projects.find(params[:project])
  location = params[:location]
  find_and_save_lat_lons(track, project, location)
  render json: {project: project.id, track: track.soundcloud_track_id, text: "Track was saved to map!"}, status: 201
end

def show
    project = current_user.projects.find(params[:id])
    setup_map(project)
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
    @user = User.find(params[:user][:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
