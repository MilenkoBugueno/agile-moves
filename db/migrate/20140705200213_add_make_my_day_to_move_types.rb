class AddMakeMyDayToMoveTypes < ActiveRecord::Migration
  def change
    add_column :move_types, :make_my_day, :boolean, :default => false
  end
end
