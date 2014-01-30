class ProjectsController < ApplicationController
  include ProjectsHelper
  require 'pry-remote'
  before_filter :signed_in_user, :except => [:show]
  before_filter :correct_user,  only: [:create]

def new
  @tracks = current_user.library.tracks.all
end

def create
  project = @user.projects.create(params[:project])
  redirect_to "/projects/#{project.id}/edit"
end

def edit
  @project = Project.find(params[:id])
  gon.project_id = @project.id
  if current_user.id != @project.user_id
    render "error"
  else
    @tracks = current_user.library.tracks.all
  end
end

def update
  track = current_user.library.tracks.find_by_soundcloud_track_id(params[:track])
  project = current_user.projects.find(params[:project])
  location = params[:location]
  region = params[:region]
  project.update_attributes(region: region)
  find_and_save_lat_lons(track, project, location)
  render json: {project: project.id, track: track.soundcloud_track_id, text: "Track was saved to map!"}, status: 201
end

def show
    @project = Project.find(params[:id])
    if current_user
      project = current_user.projects.find(params[:id])
      gon.project_id = project.id
      gon.project_region = project.region
      setup_map(project)
    else
      project = Project.find(params[:id])
      setup_map(project)
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
    @user = User.find(params[:user][:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
