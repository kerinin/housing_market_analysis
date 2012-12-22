class UniquenessConstraints < ActiveRecord::Migration
  def up
    add_index :owners, [:name, :mailing_address], :unique => true
    add_index :structures, [:property_id, :segment_id], :unique => true
    add_index :lands, [:property_id, :land_id], :unique => true
    add_index :historical_values, [:property_id, :date], :unique => true
  end

  def down
  end
end
