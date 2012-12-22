class HistoricalValue < ActiveRecord::Base
  belongs_to :property

  attr_accessible :date, :assessed_value

  validates_presence_of :date, :assessed_value
end
