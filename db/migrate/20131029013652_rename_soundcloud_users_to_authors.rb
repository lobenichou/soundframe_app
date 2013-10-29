class RenameSoundcloudUsersToAuthors < ActiveRecord::Migration
  def change
    rename_table :soundcloud_users, :authors
  end
end
