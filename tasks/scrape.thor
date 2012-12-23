class Scrape < Thor
  desc "within_radius_of RADIUS PROP_ID", "Queue scraping of parcels within RADIUS feet of parcel PROP_ID"
  def within_radius_of(radius, prop_id)
    raise ArgumentError unless property = Property.find_by_prop_id(prop_id)

    scope = Property.select([:id, :prop_id]).not_scraped.
      within_radius_of(radius.to_i, property.geom)

    puts "Adding #{scope.count} parcels"

    scope.find_each do |property_to_scrape|
      ScrapeTcadWorker.perform_async(property_to_scrape.prop_id)
    end
  end
end
