class CarMake < ActiveRecord::Base

  def to_s
    "#{year} #{make_name} #{cmodel_name}"
  end
end
