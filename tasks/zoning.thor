class Zoning < Thor
  desc "associate_zone_objects", "Associates Properties with their appropriate Zone (creating the Zone if necessary)"
  def associate_properties
    Property.where(:zoning_use => nil).find_each do |property|
      if zo = property.zone_object
        property.update_attributes(
          :zoning_use => zoning_use(zo.zoning_zty),
          :zoning_name => zo.zoning_zty
        )
      end
    end
  end

  desc "zone_object_use", "Associates Properties with their appropriate Zone (creating the Zone if necessary)"
  def zone_object_use
    ZoneObject.where(:zoning_use => nil).find_each do |zo|
      zo.update_attribute(:zoning_use, zoning_use(zo.zoning_zty))
    end
  end

  def zoning_use(zoning_name)
    case zoning_name.match(/^(?:I-)?([\/\w]+)/)[1].downcase.to_sym
    when :la, :rr, :sf, :mf, :mh
      :residential
    when :no, :lo, :go, :cr, :lr, :gr, :l, :cbd, :dmu, :"w/lo", :cs, :ch
      :commercial
    when :ip, :mi, :li, :"r&d"
      :industrial
    when :dr, :av, :ag, :pud, :p, :tn, :tod, :nbg
      :special_purpose
    else
      :unknown
    end
  end
end
