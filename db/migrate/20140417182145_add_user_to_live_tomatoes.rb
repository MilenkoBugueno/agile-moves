class AddUserToLiveTomatoes < ActiveRecord::Migration
  def change
    add_column :live_tomatoes, :userid, :integer
  end
end
