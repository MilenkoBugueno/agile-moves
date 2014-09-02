class AddResultsToMove < ActiveRecord::Migration
  def change
    add_column :moves, :results, :text
  end
end
