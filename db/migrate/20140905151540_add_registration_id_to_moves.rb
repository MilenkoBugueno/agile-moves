class AddRegistrationIdToMoves < ActiveRecord::Migration
  def change
    add_column :moves, :registration_id, :integer
  end
end
