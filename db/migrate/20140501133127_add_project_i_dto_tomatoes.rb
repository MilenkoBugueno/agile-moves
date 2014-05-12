class AddProjectIDtoTomatoes < ActiveRecord::Migration
  def change
    add_column :tomatoes, :project_id, :integer
  end
end
