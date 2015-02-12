class AddForeignKeyToCarProfile < ActiveRecord::Migration
  def change
    add_column :car_profiles, :user_id, :integer
    add_foreign_key :car_profiles, :users
  end
end
