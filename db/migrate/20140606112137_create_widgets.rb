class CreateWidgets < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.string :title
      t.string :path
      t.integer :widget_type

      t.timestamps
    end
  end
end
