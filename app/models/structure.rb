class Structure < ActiveRecord::Base
  belongs_to :property

  attr_accessible :segment_id, :type_code, :description, :year_built, :area

  validates_presence_of :segment_id, :type_code, :area
end
