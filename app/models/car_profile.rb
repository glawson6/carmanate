class CarProfile < ActiveRecord::Base
  before_save { name.downcase! if name }

  belongs_to :user
  #has_many :maintenance_actions, dependent: :destroy

  validates :name, presence: true, length: { maximum: 254 }, uniqueness: { case_sensitive: false,scope: :user_id }

  def to_s
    "#{make}-#{model}-#{year}-#{engine_code}"
  end
  def year_make_model
    "#{year} #{make} #{model}"
  end
end
