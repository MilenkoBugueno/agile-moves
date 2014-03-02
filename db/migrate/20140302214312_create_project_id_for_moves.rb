class CreateProjectIdForMoves < ActiveRecord::Migration
  def change
    add_column :moves, :project_id, :integer
  end
end
