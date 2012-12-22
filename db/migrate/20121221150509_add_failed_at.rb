class AddFailedAt < ActiveRecord::Migration
  def up
    add_column :properties, :scrape_failed_at, :datetime
    add_index :properties, :scrape_failed_at
  end

  def down
  end
end
