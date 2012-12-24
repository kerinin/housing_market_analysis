class Recalculate < Thor
  desc "scraped_but_nil VALUE", "Calculate VALUE for properties which have been scraped, but for which VALUE is nil"
  def scraped_but_nil(to_calculate)
    scope = Property.select([:id]).scraped.where(to_calculate => nil)

    puts "Adding #{scope.count} properties"
    scope.find_each do |property|
      RecalculateWorker.perform_async(property.id, to_calculate)
    end
  end

  desc "scraped_where VALUE TEST_PROPERTY TEST_VALUE", "Calculate VALUE for properties which have been scraped, and where TEST_PROPERTY = TEST_VALUE"
  def scraped_where(to_calculate, test_property, test_value)
    scope = Property.select([:id]).scraped.where(test_property => test_value)

    puts "Adding #{scope.count} properties"
    scope.find_each do |property|
      RecalculateWorker.perform_async(property.id, to_calculate)
    end
  end

  desc "scraped_where_not VALUE TEST_PROPERTY TEST_VALUE", "Calculate VALUE for properties which have been scraped, and where TEST_PROPERTY != TEST_VALUE"
  def scraped_where_not(to_calculate, test_property, test_value)
    scope = Property.select([:id]).scraped.where("properties.? != ?", test_property, test_value)

    puts "Adding #{scope.count} properties"
    scope.find_each do |property|
      RecalculateWorker.perform_async(property.id, to_calculate)
    end
  end
end
