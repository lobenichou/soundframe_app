class ProjectsController < ApplicationController
  include ProjectsHelper
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

def update_track_location
  track = current_user.library.tracks.find_by_soundcloud_track_id(params[:track])
  project = current_user.projects.find(params[:project])
  location = params[:location]
  find_and_save_lat_lons(track, project, location)
end

def update_map_region
  project = current_user.projects.find(params[:project])
  region = params[:region]
  updated_project = project.update_attributes(region: region)
  if updated_project
    render json: {project: project.id, track: track.soundcloud_track_id, text: "The map region's was set!"}, status: 201
  else
    render json: {errors: updated_project.errors.full_messages}, status: 422
  end
end

def change_map_region
  project = current_user.projects.find(params[:project])
  if project.region != nil
    project.update_attributes(region: nil)
  end
  render json: {text: "The map region's was set!"}, status: 201
end

def add_image_to_track
  track = current_user.library.tracks.find_by_soundcloud_track_id(params[:track_id])
  project = current_user.projects.find(params[:id])
  image = params[:project][:image]
  add_image(track, project, image)
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

def destroy
  project = current_user.projects.find(params[:id])
  project.destroy
  render json: {project: project.id}, status: 201
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
