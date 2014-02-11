class RemoveTomatoIdFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :tomato_id
  end
end
