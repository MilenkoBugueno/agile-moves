class CreateLiveTomatoes < ActiveRecord::Migration
  def change
    create_table :live_tomatoes do |t|
      t.text :title
      t.time :starttime
      t.time :endttime
      t.integer :currenttime

      t.timestamps
    end
  end
end
