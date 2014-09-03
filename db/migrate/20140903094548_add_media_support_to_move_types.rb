class AddMediaSupportToMoveTypes < ActiveRecord::Migration
  def change
    add_column :move_types, :has_media, :boolean
  end
end
