class TcadDataForProperties < ActiveRecord::Migration
  def up
    remove_column :properties, :land_value

    change_table :properties do |t|
      t.string :address
      t.string :legal_name
      t.float :land_value
      t.float :improvement_value
      t.float :assessed_value
      t.datetime :scraped_at

      t.belongs_to :owner

      t.timestamps
    end

    add_index :properties, :scraped_at
    add_index :properties, :prop_id
  end

  def down
  end
end
