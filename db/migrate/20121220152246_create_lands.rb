class CreateLands < ActiveRecord::Migration
  def up
    create_table :lands do |t|
      t.string :land_id
      t.string :type_code
      t.float :size_acres
      t.float :size_sqft

      t.belongs_to :property

      t.timestamps
    end
 
  end

  def down
  end
end
