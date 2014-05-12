class AddRatingtoLivetomatoes < ActiveRecord::Migration
  def change
    add_column :live_tomatoes, :thumb_rating, :integer
    add_column :live_tomatoes, :star_rating, :integer
  end
end
