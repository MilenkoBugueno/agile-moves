class ChangeStateTitle < ActiveRecord::Migration
  def change
    remove_column :states, :title
    add_column :states, :title, :string
  end
end
