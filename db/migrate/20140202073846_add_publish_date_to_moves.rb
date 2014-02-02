class AddPublishDateToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :publish_date, :date
  end
end
