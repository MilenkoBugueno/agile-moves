class AddReviewerTeamToMoves < ActiveRecord::Migration
  def change
    create_table :moves_users, :id => false do |t| 
      t.integer :move_id
      t.integer :user_id
    end
    add_index :moves_users, [:move_id, :user_id] 
  end
end