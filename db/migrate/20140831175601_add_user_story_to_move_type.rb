class AddUserStoryToMoveType < ActiveRecord::Migration
  def change
    add_column :move_types, :is_user_story, :boolean
  end
end
