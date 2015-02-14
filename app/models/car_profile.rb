class CarProfile < ActiveRecord::Base
  before_save { name.downcase! }

  attr_reader :id, :engine_code
  belongs_to :user
  has_many :maintenance_actions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 254 }, uniqueness: { case_sensitive: false }
end
