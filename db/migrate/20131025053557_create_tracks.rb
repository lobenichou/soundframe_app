class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.string :genre
      t.string :permalink_url
      t.string :artwork_url
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.integer :soundcloud_track_id

      t.timestamps
    end
  end
end
