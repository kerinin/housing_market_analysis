class Zoning < Thor
  desc "associate_zone_objects", "Associates Properties with their appropriate Zone (creating the Zone if necessary)"
  def associate_properties
    Property.where(:zoning_short_name => nil).find_each do |property|
      if zo = property.zone_object
        property.update_attributes(
          :zoning_name => zo.zoning_zty.match(/^(\w+)/)[0],
          :zoning_full_name => zo.zoning_zty,
          :zoning_short_name => zo.zoning_zty.match(/^([A-Z]+)/)[0],
        )
      end
    end
  end
end
