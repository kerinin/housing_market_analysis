class CreateOwners < ActiveRecord::Migration
  def up
    create_table :owners do |t|
      t.string :name
      t.string :mailing_address

      t.timestamps
    end
  end

  def down
  end
end
