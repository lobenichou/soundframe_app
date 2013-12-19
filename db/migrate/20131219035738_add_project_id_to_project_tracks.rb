class AddProjectIdToProjectTracks < ActiveRecord::Migration
  def change
    add_column :project_tracks, :project_id, :integer
  end
end
