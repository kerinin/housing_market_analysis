class Land < ActiveRecord::Base
  belongs_to :property

  attr_accessible :land_id, :type_code, :size_acres, :size_sqft
end
