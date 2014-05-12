class RenameEndttime < ActiveRecord::Migration
  def change
    rename_column :live_tomatoes, :endttime, :endtime
  end
end
