class RemoveLatitudeFromTracks < ActiveRecord::Migration
   def up
    remove_column :tracks, :latitude
  end

  def down
    add_column :tracks, :latitude, :float
  end
end
