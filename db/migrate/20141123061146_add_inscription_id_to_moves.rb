class AddInscriptionIdToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :inscription_id, :integer
    remove_column :moves, :registration_id
  end
end
