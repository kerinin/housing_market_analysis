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

If you're starting from a new db:
``` sh
bundle
rbenv rehash
thor gis_data:load_shp $TCAD_SHAPEFILE
rake db:migrate
```

If you're going to use Taps to transfer an existing DB (Assuming you're pusing data to Leo from another box):
``` sh
thor db:push $USERNAME $PASSWORD
```

Start the sidekiq workers with `sidekiq -c 10` (10 concurrent threads - if you want more you'll probably need
to increase `pool` in `config/database.yml`


