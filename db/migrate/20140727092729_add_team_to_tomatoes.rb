class AddTeamToTomatoes < ActiveRecord::Migration
  def change
    create_table :tomatoes_users, :id => false do |t|
      t.integer :tomato_id
      t.integer :user_id
    end
    add_index :tomatoes_users, [:tomato_id, :user_id]
  end
end
