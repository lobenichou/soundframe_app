class AddAuthorIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :author_id, :integer
  end
end
