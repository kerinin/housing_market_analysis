class ZoningUse < ActiveRecord::Migration
  def up
    remove_column :properties, :zoning_full_name
    remove_column :properties, :zoning_short_name

    add_column :properties, :zoning_use, :string
    add_index :properties, :zoning_use
  end

  def down
  end
end
