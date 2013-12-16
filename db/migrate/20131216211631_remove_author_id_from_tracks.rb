class RemoveAuthorIdFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :author_id
  end

  def down
    add_column :tracks, :author_id, :integer
  end
end
