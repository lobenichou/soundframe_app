class Library < ActiveRecord::Base
  attr_accessible :user_id

  belongs_to :user
  has_many :library_tracks
  has_many :tracks, through: :library_tracks

end
