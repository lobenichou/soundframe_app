class Project < ActiveRecord::Base
  attr_accessible :description, :title, :user_id, :region

  belongs_to :user
  has_many :project_tracks
  has_many :tracks, through: :project_tracks

  validates :title, presence: true
  validates :description, presence: true

end
