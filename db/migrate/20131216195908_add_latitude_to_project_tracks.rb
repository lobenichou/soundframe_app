class AddLatitudeToProjectTracks < ActiveRecord::Migration
  def change
    add_column :project_tracks, :latitude, :float
  end
end
