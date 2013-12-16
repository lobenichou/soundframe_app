class CreateLibraryTracks < ActiveRecord::Migration
  def change
    create_table :library_tracks do |t|
      t.integer :library_id
      t.integer :track_id

      t.timestamps
    end
  end
end
