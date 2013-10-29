class Author < ActiveRecord::Base
  attr_accessible :soundcloud_user_id, :soundcloud_username, :tracks

  has_many :tracks

end
