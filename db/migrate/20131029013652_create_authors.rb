class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.integer :soundcloud_user_id
      t.string :soundcloud_username
      t.string :tracks

      t.timestamps
    end
  end
end
