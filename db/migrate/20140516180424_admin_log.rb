class AdminLog < ActiveRecord::Migration
  def change
    create_table "admin_logs", :force => true do |t|
      t.string "user_id"
      t.string "browser"
      t.string "ip_address"
      t.string "controller"
      t.string "action"
      t.string "params"
      t.string "title"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
