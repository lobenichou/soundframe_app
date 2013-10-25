class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :soundcloud_user_id
      t.string :soundcloud_username
      t.string :tracks

      t.timestamps
    end
  end
end
