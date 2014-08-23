class AddResultsToTomato < ActiveRecord::Migration
  def change
    add_column :tomatoes, :results, :text
  end
end
