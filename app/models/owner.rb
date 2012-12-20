class Owner < ActiveRecord::Base
  has_many :properties

  attr_accessible :name, :mailing_address
end
