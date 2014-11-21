class CreateInscriptions < ActiveRecord::Migration
  def change
    create_table :inscriptions do |t|
      t.integer :certification_id
      t.date :start_date
      t.date :end_date
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
