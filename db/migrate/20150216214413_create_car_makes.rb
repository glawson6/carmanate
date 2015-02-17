class CreateCarMakes < ActiveRecord::Migration
  def change
    create_table :car_makes do |t|
      t.string :external_id
      t.string :make_name
      t.string :make_nice_name
      t.string :cmodel_name
      t.string :cmodel_nice_name
      t.integer :year
      t.timestamps null: false
    end
  end
end
