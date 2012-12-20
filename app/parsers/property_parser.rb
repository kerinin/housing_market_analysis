require 'wombat'

class PropertyParser
  include Wombat::Crawler

  attr_accessor :property_id

  def initialize(property_id)
    @property_id = property_id
    base_url "http://www.traviscad.org/travisdetail.php?theKey=#{property_id}&show_history=Y"

    super()
  end

  property do
    address               %q(xpath=//td[.="Location"]/following-sibling::td)
    legal_name            %q(xpath=//td[.="Legal"]/following-sibling::td)

    land_value            %q(xpath=//td/font[.="Land Value"]/parent::td/following-sibling::td/p) do |a|
      a.gsub(",","_")
    end

    improvement_value     %q(xpath=//td/font[.="Improvement Value"]/parent::td/following-sibling::td/p) do |a|
      a.gsub(",","_")
    end

    assessed_value        %q(xpath=//td/font[.="Assessed Value"]/parent::td/following-sibling::td/p) do |a|
      a.gsub(",","_")
    end
  end

  owner do
    name            %q(xpath=//td[.="Owner's Name"]/following-sibling::td)
    mailing_address %q(xpath=//td[.="Mailing Address"]/following-sibling::td) do |s|
      s.gsub("\t","").gsub(/[\s]{2,}/," ")
    end
  end

  structures %q(xpath=//table//td[.='Segment Information']/ancestor::table[1]/following-sibling::table//tr[@bgcolor="#FFFFFF"]), :iterator do
    segment_id "xpath=td[2]"
    type_code "xpath=td[3]"
    description "xpath=td[4]"
    year_built "xpath=td[6]"
    area "xpath=//td[7]" do |a|
      a.gsub(",","_")
    end
  end

  lands %q(xpath=//table//td[.='Land Information']/ancestor::table[1]/following-sibling::table//tr[@bgcolor="#FFFFFF"]), :iterator do
    land_id "xpath=td[1]"
    type_code "xpath=td[2]"
    size_acres "xpath=td[5]" do |a|
      a.gsub(",","_")
    end
    size_sqft "xpath=td[8]" do |a|
        a.gsub(",","_")
    end
  end

  historical_values %q(xpath=//td[.='Certified Value History']/ancestor::table[1]/following-sibling::table//tr[@bgcolor="#F9F9F9"]/following-sibling::tr[@bgcolor="#FFFFFF"][1]), :iterator do
    year "xpath=td[1]"
    assessed_value "xpath=td[4]" do |a|
      a.gsub(",","_")
    end
  end
end
