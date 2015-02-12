class CreateCarProfiles < ActiveRecord::Migration
  def change
    create_table :car_profiles do |t|
      t.string :external_id
      t.string :make
      t.string :model
      t.integer :year

      t.timestamps null: false
    end
  end
end
