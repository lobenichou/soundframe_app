class ProjectTrack < ActiveRecord::Base
  attr_accessible :project_id, :text, :track_id

  belongs_to :project
  belongs_to :track

end
