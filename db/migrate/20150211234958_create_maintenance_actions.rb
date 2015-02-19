class CreateMaintenanceActions < ActiveRecord::Migration
  def change
    create_table :maintenance_actions do |t|
      t.integer :model_year_id
      t.integer :car_make_id
      t.integer :external_id
      t.string :engine_code
      t.string :transmission_code
      t.string :interval_month
      t.integer :interval_mileage
      t.integer :frequency
      t.string :action
      t.string :item
      t.string :item_description
      t.float :labor_units
      t.float :parts_units
      t.float :part_cost_per_unit
      t.string :drive_type
      t.string :model_year

      t.timestamps null: false
    end
  end
end
