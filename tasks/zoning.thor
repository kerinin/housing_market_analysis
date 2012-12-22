class Zoning < Thor
  desc "associate_zone_objects", "Associates Properties with their appropriate Zone (creating the Zone if necessary)"
  def associate_properties
    Property.where(:zoning_use => nil).find_each do |property|
      if zo = property.zone_object
        zoning_use = case zo.zoning_zty.match(/^(?:I-)?([\/\w]+)/)[1].downcase.to_sym
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

        property.update_attributes(
          :zoning_use => zoning_use,
          :zoning_name => zo.zoning_zty
        )
      end
    end
  end
end
