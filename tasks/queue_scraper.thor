class QueueScraper < Thor
  desc "within_radius_of RADIUS PROP_ID", "Queue scraping of parcels within RADIUS feet of parcel PROP_ID"
  method_option :max_days, :type => :numeric, :default => 60, :description => "Maximum days since last scrape"
  def within_radius_of(radius, prop_id)
    raise ArgumentError unless property = Property.find_by_prop_id(prop_id)

    ScrapeTcadWorker.perform_async(prop_id)
    scope = Property.select([:id, :prop_id]).
      where{ scraped_at == nil || scraped_at < options.max_days.ago }.
      within_radius_of(radius.to_i, property.geom)

    puts "Adding #{scope.count} parcels"

    scope.find_each do |property_to_scrape|
      ScrapeTcadWorker.perform_async(property_to_scrape.prop_id)
    end
  end
end
