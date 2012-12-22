class Zone < ActiveRecord::Base
  has_many :zone_objects
  has_many :properties

  attr_accessible :name, :full_name

  validates_presence_of :name, :full_name
end
