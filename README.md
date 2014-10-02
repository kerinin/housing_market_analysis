# Housing Market Analysis (for Austin)

## Install

Environmental dependencies:
* Jruby 1.7.1
* Node (for coffescript precompilation)
* Redis
* PostGIS
* Taps (conflicts with sidekiq, needs to be installed in another dir)

The databse `housing_market` needs to be set up for user `housing_market:housing_market`
with PostGIS extensions.  Setup instructions: [Ubuntu](http://postgis.refractions.net/documentation/manual-1.5/ch02.html#id418654),
[OSX](http://postgis.refractions.net/documentation/manual-2.0/postgis_installation.html#create_new_db_extensions)

If your postgres setup doesn't create a user for you account, you'll need to run (Ubuntu)
``` sh
sudo -u postgres createuser -s -w kerinin
```

If you're starting from a new db:
``` sh
bundle
rbenv rehash
thor gis_data:load_shp $TCAD_SHAPEFILE objects
thor gis_data:load_shp $ZONING_SHAPEFILE zone_objects
rake db:migrate
thor zoning:associate_properties
```

If you're going to use Taps to transfer an existing DB (Assuming you're pusing data to Leo from another box):
``` sh
# On source machine
pg_dump -a -Fc housing_market > housing_market.dump

# On target machine
rake db:create
rake db:schema:load
pg_restore -a -v -Fc -d housing_market housing_market.dump
```

Start the sidekiq workers with `sidekiq -c 10` (10 concurrent threads - if you want more you'll probably need
to increase `pool` in `config/database.yml`

## Tile Server Install

You'll need to install osm2pgsql, on OSX just `brew install --HEAD osm2pgsql`

``` sh
pip install TileStache ModestMaps Werkzeug PIL Blit sympy
tilestache-server.py -c config/tilestache.json &
wget http://overpass.osm.rambler.ru/cgi/xapi?map?bbox=-97.94474697260601,30.078532770620534,-97.5208695238209,30.511870070750014 -O travis_county.osm
osm2pgsql -h localhost -d housing_market -U housing_market --prefix "osm" travis_county.osm
```
