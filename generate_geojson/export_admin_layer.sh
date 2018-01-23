ogr2ogr -f GeoJSON /data/geojson/admin_10.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, name, z_index, original_id, geom FROM visdata.admin_polygon WHERE original_source='TOP10NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/admin_50.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, name, z_index, original_id, geom FROM visdata.admin_polygon WHERE original_source='TOP50NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/admin_100.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, name, z_index, original_id, geom FROM visdata.admin_polygon WHERE original_source='TOP100NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/admin_250.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, name, z_index, original_id, geom FROM visdata.admin_polygon WHERE original_source='TOP250NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/admin_500.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, name, z_index, original_id, geom FROM visdata.admin_polygon WHERE original_source='TOP500NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/admin_1000.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, name, z_index, original_id, geom FROM visdata.admin_polygon WHERE original_source='TOP1000NL'" -lco COORDINATE_PRECISION=6
