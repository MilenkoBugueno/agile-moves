class AddMakeMySprintToMoves < ActiveRecord::Migration
  def change
    add_column :move_types, :make_my_sprint, :boolean
    add_column :moves, :start_date, :date
  end
end
