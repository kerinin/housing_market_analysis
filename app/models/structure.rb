class Structure < ActiveRecord::Base
  belongs_to :property

  attr_accessible :segment_id, :type_code, :description, :year_built, :area
end
