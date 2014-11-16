class AddProjectidToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :project_id, :integer
  end
end
