class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :title
      t.text :description
      t.string :artist
      t.string :composer
      t.string :arranger
      t.string :writer
      t.string :catalog
      t.string :publisher
      t.integer :state_id

      t.timestamps
    end
  end
end
