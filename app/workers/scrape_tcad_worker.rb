require 'wombat'

class ScrapeTcad
  include Sidekiq::Worker

  def perform(property_id)
    Property.find_or_create_by_objectid(property_id).fetch_from_tcad!
  end
end
