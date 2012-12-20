class HistoricalValue < ActiveRecord::Base
  belongs_to :property

  attr_accessible :year, :assessed_value
end
