class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.text :body
      t.integer :position
      t.integer :title
      t.integer :visibility

      t.timestamps
    end
  end
end
