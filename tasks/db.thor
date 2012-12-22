class GisData < Thor
  desc "dump", "Dump the current database to file"
  def dump
    `pg_dump -a -Fc housing_market > housing_market.dump`
  end

  desc "restore", "Restore the database from file"
  def restore
    `rake db:drop`
    `rake db:schema:load`
    `pg_restore -a -v -Fc -d housing_market housing_market.dump`
  end
end
