ogr2ogr -f GeoJSON /data/geojson/water-line_bgt.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, z_index, original_id, geom FROM visdata.water_line WHERE original_source = 'BGT'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/water-line_10.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, z_index, original_id, geom FROM visdata.water_line WHERE original_source='TOP10NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/water-line_50.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, z_index, original_id, geom FROM visdata.water_line WHERE original_source='TOP50NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/water-line_100.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, z_index, original_id, geom FROM visdata.water_line WHERE original_source='TOP100NL'" -lco COORDINATE_PRECISION=6

#ogr2ogr -f GeoJSON /data/geojson/water-line_250.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, z_index, original_id, geom FROM visdata.water_line WHERE original_source = 'TOP250NL'" -lco COORDINATE_PRECISION=6

# No waterways for TOP500NL and TOP1000NL
