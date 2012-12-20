class CreateHistoricalValue < ActiveRecord::Migration
  def up
    create_table :historical_values do |t|
      t.integer :year
      t.integer :assessed_value

      t.belongs_to :property

      t.timestamps
    end
  end

  def down
  end
end
