class AddImageToProjectTracks < ActiveRecord::Migration
  def change
    add_column :project_tracks, :image, :string
  end
end
