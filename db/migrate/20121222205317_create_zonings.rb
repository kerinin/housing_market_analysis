class CreateZonings < ActiveRecord::Migration
  def change
    change_table :zone_objects do |t|
      t.belongs_to :zone

      t.timestamps
    end

    change_table :properties do |t|
      t.belongs_to :zone
    end
  end
end
