class RenameTomatoidToTomatoId < ActiveRecord::Migration
  def change
    rename_column :live_tomatoes, :tomatoid, :tomato_id
  end
end
