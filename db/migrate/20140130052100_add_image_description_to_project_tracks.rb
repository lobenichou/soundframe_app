class AddImageDescriptionToProjectTracks < ActiveRecord::Migration
  def change
    add_column :project_tracks, :imageDescription, :string
  end
end
