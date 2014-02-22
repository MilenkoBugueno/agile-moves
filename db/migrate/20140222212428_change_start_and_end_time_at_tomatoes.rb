class ChangeStartAndEndTimeAtTomatoes < ActiveRecord::Migration
  def change
    remove_column :tomatoes, :start_time
    remove_column :tomatoes, :end_time
    add_column :tomatoes, :start_time, :time
    add_column :tomatoes, :end_time, :time
    
  end
end
