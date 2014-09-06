class CreateTableProjectCertificates < ActiveRecord::Migration
  def change
    create_table :certifications_projects, :id => false do |t|
      t.integer :certification_id
      t.integer :project_id
    end
    add_index :certifications_projects, [:certification_id, :project_id]
  end
end
