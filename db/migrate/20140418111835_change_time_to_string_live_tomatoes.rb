class ChangeTimeToStringLiveTomatoes < ActiveRecord::Migration
  def change
    change_column :live_tomatoes, :starttime, :text
    change_column :live_tomatoes, :endtime, :text
  end
end
