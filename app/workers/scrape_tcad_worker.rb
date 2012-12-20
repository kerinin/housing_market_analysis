require 'wombat'

class ScrapeTcad
  include Sidekiq::Worker

  def perform(property_id)
    property_data = PropertyParser.new(:property_id => property_id).crawl

    property = Property.find_or_create_by_property_id(property_id)
    owner = Owner.find_or_create_by_name_and_mailing_address(property_data["owner"]["name"])

    property.owner = owner
    property.update_attributes property_data["property"]

    property_data["structures"].each do |structure_data|
      property.structures.
        find_or_create_by_segment_id(structure_data["segment_id"]).
        update_attributes(structure_data)
    end

    property_data["lands"].each do |land_data|
      property.lands.
        find_or_create_by_land_id(land_data["land_id"]).
        update_attributes(land_data)
    end
  end
end
