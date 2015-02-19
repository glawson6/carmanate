class MaintenanceAction < ActiveRecord::Base
  validates :model_year_id, presence: true
end
