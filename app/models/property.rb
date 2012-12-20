class Property < ActiveRecord::Base
  belongs_to :owner

  has_many :structures
  has_many :lands
end
