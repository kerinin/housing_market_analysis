class ScrapeTcadWorker
  include Sidekiq::Worker

  def perform(prop_id)
    property = Property.find_by_prop_id!(prop_id)

    property.fetch_from_tcad
    property.compute_fields

    property.scrape_successful
    property.save!

    puts "scraped #{prop_id}: #{property.address}"

  rescue Property::ParseError, Property::NotUniquePropIdError
    # Don't retry the task
    property.reload.scrape_failed
    property.save!
  rescue
    property.reload.scrape_failed
    property.save!
    raise
  end
end
