class DeleteCapacities < ActiveRecord::Migration
  def change
    drop_table :capacities, :force => true
  end
end
