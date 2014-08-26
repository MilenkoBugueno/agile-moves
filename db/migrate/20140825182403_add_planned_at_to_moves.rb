class AddPlannedAtToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :planned_at, :datetime
  end
end
