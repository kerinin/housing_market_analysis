class AddZoningUseToObjects < ActiveRecord::Migration
  def change
    add_column :zone_objects, :zoning_use, :string
    add_index :zone_objects, :zoning_use
  end
end
