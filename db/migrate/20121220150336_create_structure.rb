class CreateStructure < ActiveRecord::Migration
  def up
    create_table :structures do |t|
      t.string :segment_id
      t.string :type_code
      t.string :description
      t.integer :year_built
      t.float :area

      t.belongs_to :property

      t.timestamps
    end
  end

  def down
  end
end
