class Property < ActiveRecord::Base
  class ParseError < StandardError; end

  belongs_to :owner

  has_many :structures
  has_many :lands
  has_many :historical_values

  attr_accessible :address, :legal_name, :land_value, :improvement_value, :assessed_value, :scraped_at

  before_save :compute_fields

  def self.within_radius_of(radius, reference_geom)
    # NOTE: radius is in feet, assuming SRID 2277
    where{st_distance(reference_geom, geom) < radius}
  end

  def self.order_by_distance_from(reference_geom)
    order{st_distance(reference_geom, geom)}
  end

  def self.scraped(since=30.days.ago)
    where{ scraped_at > since }
  end

  def self.residential
    where{ has_residential == true }
  end

  def residential?
    has_residential == true
  end

  def fetch_from_tcad!
    property_data = PropertyParser.new(prop_id).crawl

    raise ParseError unless property_data["owner"].has_key?("name")
    raise ParseError unless property_data["owner"].has_key?("mailing_address")
    raise ParseError unless property_data["property"].has_key?("assessed_value")

    owner = Owner.find_or_create_by_name_and_mailing_address(
      property_data["owner"]["name"],
      property_data["owner"]["mailing_address"]
    )

    property_data["structures"][0...-1].each do |structure_data|
      structures.
        find_or_initialize_by_segment_id(structure_data["segment_id"]).
        update_attributes(structure_data.reject {|k,v| v == ""})
    end

    property_data["lands"].each do |land_data|
      lands.
        find_or_initialize_by_land_id(land_data["land_id"]).
        update_attributes(land_data.reject {|k,v| v == ""})
    end

    property_data["historical_values"].each do |historical_value|
      historical_values.
        find_or_initialize_by_date(historical_value["date"]).
        update_attributes(historical_value.reject {|k,v| v == ""})
    end

    self.owner = owner
    update_attributes property_data["property"].merge(:scraped_at => DateTime.now)
  end

  private

  def compute_fields
    compute_lot_area
    compute_weighted_structure_age
    compute_assessed_value_change_since_2008
    compute_assessed_value_change_since_2000
    compute_has_residential
    compute_hvac_residential_area
    compute_assessed_value_per_hvac_sf
    compute_assessed_value_per_lot_sf
    compute_improvement_value_per_hvac_sf
    compute_land_value_per_lot_sf
  end

  def compute_lot_area
    self.lot_area = lands.sum(:size_sqft)
  end

  def compute_weighted_structure_age
    n = structures.sum("year_built * area").to_f
    d = structures.sum(:area).to_f
    self.weighted_structure_age = n / d if n > 0
  end

  def compute_assessed_value_change_since_2008
    if previous_value = historical_values.find_by_date(DateTime.ordinal(2008))
      self.assessed_value_change_since_2008 = assessed_value - previous_value.assessed_value
    end
  end

  def compute_assessed_value_change_since_2000
    if previous_value = historical_values.find_by_date(DateTime.ordinal(2000))
      self.assessed_value_change_since_2008 = assessed_value - previous_value.assessed_value
    end
  end

  def compute_has_residential
    self.has_residential = true if structures.where{description == 'HVAC RESIDENTIAL'}.exists?
  end

  def compute_hvac_residential_area
    if residential?
      self.hvac_residential_area            = structures.where{description == 'HVAC RESIDENTIAL'}.sum(:area)
    end
  end

  def compute_assessed_value_per_hvac_sf
    if residential?
      self.assessed_value_per_hvac_sf       = assessed_value / hvac_residential_area if hvac_residential_area > 0
    end
  end

  def compute_assessed_value_per_lot_sf
    if residential?
      self.assessed_value_per_lot_sf        = assessed_value / lot_area if lot_area > 0
    end
  end

  def compute_improvement_value_per_hvac_sf
    if residential?
      self.improvement_value_per_hvac_sf    = improvement_value / hvac_residential_area if hvac_residential_area > 0
    end
  end

  def compute_land_value_per_lot_sf
    if residential?
      self.land_value_per_lot_sf           = land_value / lot_area if lot_area > 0
    end
  end
end
