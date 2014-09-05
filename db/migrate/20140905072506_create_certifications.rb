class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.string :title
      t.string :label
      t.integer :level_id
      t.text :description
      t.integer :user_id
      t.integer :move_type_id
      t.integer :approvements
      t.integer :moves_number

      t.timestamps
    end
  end
end
