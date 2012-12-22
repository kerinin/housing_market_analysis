class ScrapeTcadWorker
  include Sidekiq::Worker

  def perform(prop_id)
    property = Property.find_by_prop_id!(prop_id)

    property.fetch_from_tcad!

    puts "scraped #{prop_id}: #{property.address}"
  rescue Property::ParseError
    property.update_attribute :scrape_failed_at, DateTime.now
  end
end
