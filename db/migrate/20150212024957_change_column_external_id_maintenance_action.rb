class ChangeColumnExternalIdMaintenanceAction < ActiveRecord::Migration
  def change
    change_column :maintenance_actions, :external_id, :string
  end
end
