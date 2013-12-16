class RemoveLongitudeFromTracks < ActiveRecord::Migration
  def up
    remove_column :tracks, :longitude
  end

  def down
    add_column :tracks, :longitude, :float
  end
end
