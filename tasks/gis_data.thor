class GisData < Thor
  desc "load_shp SHP_PATH TARGET_TABLE TARGET_DB", "Load data from a SHP file to the postgres database"
  method_option :database_name, :default => "housing_market"
  method_option :target_geom, :default => "geom", :description => "The target geometry column name in the DB"
  method_option :username, :default => "housing_market"
  def load_shp(shp_path, table_name)
    # NOTE: The tcad data is in SRID 2277, if you're importing from another data source, you'll need to specify the projection
    `shp2pgsql -g #{options.target_geom} -s 2277 -I #{shp_path} public.#{table_name} | psql -h localhost -d #{options.database_name} -U #{options.username}`
    `echo "ALTER TABLE #{table_name} RENAME gid TO id;" | psql -h localhost -d #{options.database_name} -U #{options.username}`
  end
end
