class AddComputedFields < ActiveRecord::Migration
  def up
    change_table :properties do |t|
      t.float :lot_area
      t.float :assessed_value_change_since_2008
      t.float :assessed_value_change_since_2000
      t.boolean :has_residential
      t.float :hvac_residential_area
      t.float :assessed_value_per_hvac_sf
      t.float :assessed_value_per_lot_sf
      t.float :improvement_value_per_hvac_sf
      t.float :land_value_per_lot_sf
    end
  end

  def down
  end
end
