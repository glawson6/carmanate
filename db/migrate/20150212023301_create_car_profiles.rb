class CreateCarProfiles < ActiveRecord::Migration
  def change
    create_table :car_profiles do |t|
      t.integer :model_year_id
      t.string :make
      t.string :model
      t.integer :year
      t.string :engine_code
      t.string :name
      t.integer :car_make_id

      t.timestamps null: false
    end
  end
end
