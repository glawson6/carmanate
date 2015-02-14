class AddUniqueIndexToCarProfile < ActiveRecord::Migration
  def change
    add_index :car_profiles, :name, unique: true
  end
end
