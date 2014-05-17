class AddUsernameToAdminLog < ActiveRecord::Migration
  def change
    add_column :admin_logs, :username, :string
  end
end
