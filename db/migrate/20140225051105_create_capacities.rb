class CreateCapacities < ActiveRecord::Migration
  def change
    create_table :capacities do |t|
      t.integer :tomatoes_capacity
      t.date :publish_date
      t.integer :user_id

      t.timestamps
    end
  end
end
