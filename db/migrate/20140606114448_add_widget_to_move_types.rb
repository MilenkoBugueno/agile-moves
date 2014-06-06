class AddWidgetToMoveTypes < ActiveRecord::Migration
  def change
    create_table :move_types_widgets, :id => false do |t|
      t.integer :move_type_id
      t.integer :widget_id
    end
    add_index :move_types_widgets, [:move_type_id, :widget_id]
  end
end
