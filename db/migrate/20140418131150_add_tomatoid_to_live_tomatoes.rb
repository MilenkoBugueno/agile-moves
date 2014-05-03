class AddTomatoidToLiveTomatoes < ActiveRecord::Migration
  def change
    add_column :live_tomatoes, :tomatoid, :integer
  end
end
