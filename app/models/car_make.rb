class CarMake < ActiveRecord::Base

  def to_s
    self.cmodel_name
  end
end
