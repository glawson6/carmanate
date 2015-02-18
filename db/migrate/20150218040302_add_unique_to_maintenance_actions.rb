class AddUniqueToMaintenanceActions < ActiveRecord::Migration
  def change
    add_index(:maintenance_actions, [:external_id], unique: true)
  end
end
