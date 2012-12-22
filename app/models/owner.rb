class Owner < ActiveRecord::Base
  has_many :properties

  attr_accessible :name, :mailing_address

  validates_presence_of :name, :mailing_address
end
