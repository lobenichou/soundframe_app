class LibraryTrack < ActiveRecord::Base
  attr_accessible :library_id, :track_id

  belongs_to :track
  belongs_to :library

end
