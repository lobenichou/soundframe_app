class ProjectsController < ApplicationController
before_filter :signed_in_user
before_filter :correct_user,  only: [:create]

def new
  @tracks = current_user.library.tracks.all
end

def create
  project = @user.projects.create(params[:project])
  redirect_to new_project_path
end

def update

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
