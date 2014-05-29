class AddTomatoesToComments < ActiveRecord::Migration
  def change
    add_column :comments, :tomato_id, :integer
  end
end
