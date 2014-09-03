class AddTableMoveToMedia < ActiveRecord::Migration
  def change
    create_table :media_moves, :id => false do |t|
      t.integer :medium_id
      t.integer :move_id
    end
    add_index :media_moves, [:medium_id, :move_id]
  end
end
