class AddRegionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :region, :string
  end
end
