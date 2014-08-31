class AddMoveIdToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :user_story_id, :integer
  end
end
