require 'wombat'

class PropertyParser
  include Wombat::Crawler

  attr_accessor :property_id

  base_url "http://http://www.traviscad.org/"
  path "/travisdetail.php?theKey=#{property_id}&show_history=Y"

  property do
    address               %w(xpath=//td[.="Location"]/following-sibling::td)
    legal_name            %w(xpath=//td[.="Legal"]/following-sibling::td)

    land_value            %w(xpath=//td/font[.="Land Value"]/parent::td/following-sibling::td/p) {|a| a.gsub(",","_")}
    improvement_value     %w(xpath=//td/font[.="Improvement Value"]/parent::td/following-sibling::td/p) {|a| a.gsub(",","_")}
    assessed_value        %w(xpath=//td/font[.="Assessed Value"]/parent::td/following-sibling::td/p) {|a| a.gsub(",","_")}
  end

  owner do
    name            %w(xpath=//td[.="Owner's Name"]/following-sibling::td)
    mailing_address %w(xpath=//td[.="Mailing Address"]/following-sibling::td)
  end

  structures %w(xpath=//table//td[.='Segment Information']/ancestor::table[1]/following-sibling::table//tr[@bgcolor="#FFFFFF"]), :iterator do
    segment_id "xpath=//td[2]"
    type_code "xpath=//td[3]"
    description "xpath=//td[4]"
    year_built "xpath=//td[6]"
    area "xpath=//td[7]" {|a| a.gsub(",","_")}
  end

  lands %w(xpath=//table//td[.='Land Information']/ancestor::table[1]/following-sibling::table//tr[@bgcolor="#FFFFFF"]), :iterator do
    land_id "xpath=//td[1]"
    type_code "xpath=//td[2]"
    size_acres "xpath=//td[5]" {|a| a.gsub(",","_")}
    size_sqft "xpath=//td[8]" {|a| a.gsub(",","_")}
  end

  # historical_value %w(xpath=//td[.='Certified Value History']/ancestor::table[1]/following-sibling::table//tr[@bgcolor="#F9F9F9"]/following-sibling::tr[@bgcolor="#FFFFFF"][1]/td[4]/text()), :iterator do
  #   year "xpath=/td[1]"
  #   assessed_value "xpath=/td[4]" do {|a| a.gsub(",","_")}
  # end
end
