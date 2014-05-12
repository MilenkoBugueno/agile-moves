class AddUsernameToLiveTomatoes < ActiveRecord::Migration
  def change
    add_column :live_tomatoes, :username, :text
  end
end
