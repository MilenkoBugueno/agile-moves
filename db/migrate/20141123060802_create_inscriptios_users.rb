class CreateInscriptiosUsers < ActiveRecord::Migration
  def change
    create_table :inscriptions_users, :id => false do |t|
      t.integer :inscription_id
      t.integer :user_id
    end
    add_index :inscriptions_users, [:inscription_id, :user_id]
  end
end
