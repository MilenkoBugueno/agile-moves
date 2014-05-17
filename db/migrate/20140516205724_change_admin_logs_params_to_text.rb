class ChangeAdminLogsParamsToText < ActiveRecord::Migration
  def change
    change_column :admin_logs, :params, :text
  end
end
