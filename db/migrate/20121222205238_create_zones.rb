class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.string :full_name

      t.timestamps
    end
  end
end
