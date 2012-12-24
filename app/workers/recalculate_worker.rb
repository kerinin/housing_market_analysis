class RecalculateWorker
  include Sidekiq::Worker

  def perform(id, to_calculate)
    property = Property.find(id)

    property.send("calculate_#{to_calculate}")
    property.save!

    puts "recalculated #{property.prop_id}: #{property.address}"
  end
end
