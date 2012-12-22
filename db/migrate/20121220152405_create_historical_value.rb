class CreateHistoricalValue < ActiveRecord::Migration
  def up
    create_table :historical_values do |t|
      t.datetime :date
      t.integer :assessed_value

      t.belongs_to :property

      t.timestamps
    end
  end

  def down
  end
end
