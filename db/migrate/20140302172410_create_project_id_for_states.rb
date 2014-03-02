class CreateProjectIdForStates < ActiveRecord::Migration
  def change
    add_column :states, :project_id, :integer
  end
end
