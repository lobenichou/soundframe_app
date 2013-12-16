class CreateProjectTracks < ActiveRecord::Migration
  def change
    create_table :project_tracks do |t|
      t.integer :track_id
      t.string :project_id
      t.text :text

      t.timestamps
    end
  end
end
