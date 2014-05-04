class AddRatingToTomatoes < ActiveRecord::Migration
  def change
    add_column :ratings, :tomato_id, :integer
  end
end
