class RemoveProjectIdFromProjectTracks < ActiveRecord::Migration
  def up
    remove_column :project_tracks, :project_id
  end

  def down
    add_column :project_tracks, :project_id, :string
  end
end
