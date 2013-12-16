class AddLongitudeToProjectTracks < ActiveRecord::Migration
  def change
    add_column :project_tracks, :longitude, :float
  end
end
