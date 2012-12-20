require 'wombat'

class ScrapeTcad
  include Sidekiq::Worker

  def perform(property_id)
    property_data = PropertyParser.new(:property_id => property_id).crawl

    property = Property.find_or_create_by_property_id(property_id)

    property.update_attributes property_data
  end
end
