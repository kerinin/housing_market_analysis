class Property < ActiveRecord::Base
end

class StateMachine < ActiveRecord::Migration
  def up
    change_table :properties do |t|
      t.string :state, :default => "not_scraped"
    end
    Property.where{scraped_at == nil}.update_all(:state => 'scraped')
    Property.where{scrape_failed_at != nil}.update_all(:state => 'scrape_failed')
  end

  def down
  end
end
