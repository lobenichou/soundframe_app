class DropAuthors < ActiveRecord::Migration
   def up
    drop_table :authors
   end

  def down
    create_table :authors do |t|
      t.integer  "soundcloud_user_id"
      t.string   "soundcloud_username"
      t.string   "tracks"
      t.timestamps
    end
  end

end
