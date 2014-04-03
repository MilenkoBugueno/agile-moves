class RenameProjectMoveTypes < ActiveRecord::Migration
  def change
    rename_table :project_move_types, :move_types_projects
  end
end
