class GisData < Thor
  desc "load_shp", "Load data from a SHP file to the postgres database"
  method_option :table_name, :default => "tcad"
  method_option :database_name, :default => "housing_market"
  method_option :username, :default => "rmichael"
  def load_shp(shp_path)
    # NOTE: The tcad data is in SRID 2277, if you're importing from another data source, you'll need to specify the projection
    `shp2pgsql -s 2277 -I #{shp_path} public.#{options.table_name} | psql -h localhost -d #{options.database_name} -U #{options.username}`
    `echo "ALTER TABLE #{options.table_name} RENAME gid TO id;" | psql -h localhost -d #{options.database_name} -U #{options.username}`
  end
end
