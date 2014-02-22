class AddPublishDateToTomatoes < ActiveRecord::Migration
  def change
    add_column :tomatoes, :publish_date, :date
  end
end
