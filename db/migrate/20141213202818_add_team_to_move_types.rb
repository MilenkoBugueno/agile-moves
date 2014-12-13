class AddTeamToMoveTypes < ActiveRecord::Migration
  def change
    add_column :move_types, :has_team, :boolean
  end
end
