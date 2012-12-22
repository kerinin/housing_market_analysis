class AddWeightedAge < ActiveRecord::Migration
  def up
    add_column :properties, :weighted_structure_age, :float
  end

  def down
  end
end
