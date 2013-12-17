class ProjectTrack < ActiveRecord::Base
  attr_accessible :project_id, :text, :track_id, :latitude, :longitude

  belongs_to :project
  belongs_to :track

end
