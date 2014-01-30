class CreateMoveTypes < ActiveRecord::Migration
  def change
    create_table :move_types do |t|
      t.text :body
      t.boolean :thumb_rating
      t.boolean :star_rating
      t.boolean :has_tomatoes
      t.string :title

      t.timestamps
    end
  end
end
