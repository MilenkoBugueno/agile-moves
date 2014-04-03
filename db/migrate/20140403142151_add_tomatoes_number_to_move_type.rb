class AddTomatoesNumberToMoveType < ActiveRecord::Migration
  def change
    add_column :move_types, :tomatoes_number, :integer
  end
end
