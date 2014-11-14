class AddDurationToCertification < ActiveRecord::Migration
  def change
    add_column :certifications, :duration, :integer
  end
end
