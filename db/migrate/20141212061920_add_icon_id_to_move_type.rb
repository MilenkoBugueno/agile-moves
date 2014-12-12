class AddIconIdToMoveType < ActiveRecord::Migration
  def change
    add_column :move_types, :icon_id, :integer
  end
end
