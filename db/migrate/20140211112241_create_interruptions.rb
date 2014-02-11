class CreateInterruptions < ActiveRecord::Migration
  def change
    create_table :interruptions do |t|
      t.text :body
      t.integer :interruption_type
      t.integer :user_id
      t.integer :tomato_id

      t.timestamps
    end
  end
end
