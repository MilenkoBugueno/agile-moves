class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.text :body
      t.integer :star_rating
      t.integer :thumb_rating
      t.integer :user_id
      t.integer :move_id

      t.timestamps
    end
  end
end
