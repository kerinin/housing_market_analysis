class Property < ActiveRecord::Base
  belongs_to :owner

  has_many :structures
  has_many :lands
  has_many :historical_values

  attr_accessible :address, :legal_name, :land_value, :improvement_value, :assessed_value

  def fetch_from_tcad!
    property_data = PropertyParser.new(objectid).crawl

    owner = Owner.find_or_create_by_name_and_mailing_address(
      property_data["owner"]["name"],
      property_data["owner"]["mailing_address"]
    )

    owner = owner
    update_attributes property_data["property"]

    property_data["structures"][0...-1].each do |structure_data|
      structures.
        find_or_create_by_segment_id(structure_data["segment_id"]).
        update_attributes(structure_data)
    end

    property_data["lands"].each do |land_data|
      lands.
        find_or_create_by_land_id(land_data["land_id"]).
        update_attributes(land_data)
    end

    property_data["historical_values"].each do |historical_value|
      historical_values.
        find_or_create_by_year(historical_value["year"]).
        update_attributes(historical_value)
    end
  end
end
