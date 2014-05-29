class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.integer :move_id
      t.integer :user_id
      t.integer :lft
      t.integer :rgt

      t.timestamps
    end
  end
end
