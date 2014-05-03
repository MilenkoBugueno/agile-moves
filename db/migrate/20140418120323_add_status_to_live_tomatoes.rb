class AddStatusToLiveTomatoes < ActiveRecord::Migration
  def change
    add_column :live_tomatoes, :status, :integer
  end
end
