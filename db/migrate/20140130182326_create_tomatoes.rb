class CreateTomatoes < ActiveRecord::Migration
  def change
    create_table :tomatoes do |t|
      t.text :body
      t.datetime :end_time
      t.datetime :start_time
      t.integer :state
      t.string :title
      t.integer :user_id
      t.integer :move_id

      t.timestamps
    end
  end
end
