class RecalculateWorker
  include Sidekiq::Worker

  def perform(id, property)
    property = Property.find(id)

    property.send("calculate_#{property}")
    property.save!

    puts "recalculated #{prop_id}: #{property.address}"
  end
end
