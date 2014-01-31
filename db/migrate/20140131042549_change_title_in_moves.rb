class ChangeTitleInMoves < ActiveRecord::Migration
  def change
    remove_column :moves, :title
    add_column :moves, :title, :string
  end
end
