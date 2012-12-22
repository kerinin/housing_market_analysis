class NewZoningFields < ActiveRecord::Migration
  def up
    # Remove old shit
    remove_column :properties, :zone_id
    remove_column :zone_objects, :zone_id
    drop_table :zones

    # Add new shit
    add_column :properties, :zoning_name, :string
    add_column :properties, :zoning_full_name, :string
    add_column :properties, :zoning_short_name, :string

    # Make it fast
    add_index :properties, :zoning_short_name
  end

  def down
  end
end
