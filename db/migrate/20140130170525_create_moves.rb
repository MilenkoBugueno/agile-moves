class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.text :body
      t.integer :move_type_id
      t.integer :user_id
      t.text :title
      t.integer :state_id

      t.timestamps
    end
  end
end
