class TcadDataForProperties < ActiveRecord::Migration
  def up
    remove_column :properties, :land_value

    change_table :properties do |t|
      t.string :address
      t.string :legal_name
      t.float :land_value
      t.float :improvement_value
      t.float :assessed_value

      t.belongs_to :owner

      t.timestamps
    end
  end

  def down
  end
end
