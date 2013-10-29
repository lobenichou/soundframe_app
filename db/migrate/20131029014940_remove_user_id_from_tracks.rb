class RemoveUserIdFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :user_id
  end

  def down
    add_column :tracks, :user_id, :integer
  end
end
