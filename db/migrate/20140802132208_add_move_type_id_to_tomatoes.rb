class AddMoveTypeIdToTomatoes < ActiveRecord::Migration
  def change
    add_column :tomatoes, :move_type_id, :integer
  end
end
