class CreateTableProjectMoveTypes < ActiveRecord::Migration
  def change
    create_table :project_move_types, :id => false do |t|
      t.integer :project_id
      t.integer :move_type_id
    end
    add_index :project_move_types, [:project_id, :move_type_id]
  end
end
