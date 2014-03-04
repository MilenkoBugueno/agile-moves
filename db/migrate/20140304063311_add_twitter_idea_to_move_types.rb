class AddTwitterIdeaToMoveTypes < ActiveRecord::Migration
  def change
    add_column :move_types, :has_twitter_idea, :bool
  end
end
