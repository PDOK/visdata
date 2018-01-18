ogr2ogr -f GeoJSON /data/geojson/water_bgt.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source = 'BGT'"

ogr2ogr -f GeoJSON /data/geojson/water_10.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source='TOP10NL'"

ogr2ogr -f GeoJSON /data/geojson/water_50.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source='TOP50NL'"

ogr2ogr -f GeoJSON /data/geojson/water_100.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source='TOP100NL'"

ogr2ogr -f GeoJSON /data/geojson/water_250.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source = 'TOP250NL'"

ogr2ogr -f GeoJSON /data/geojson/water_500.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source='TOP500NL'"

ogr2ogr -f GeoJSON /data/geojson/water_1000.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT * FROM visdata.water_polygon WHERE original_source='TOP1000NL'"
