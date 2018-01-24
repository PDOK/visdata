ogr2ogr -f GeoJSON /data/geojson/infra_bgt.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='BGT'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/infra_10.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='TOP10NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/infra_50.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='TOP50NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/infra_100.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='TOP100NL'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/infra_250.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='TOP250NL' and lod2 NOT IN ('local')" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/infra_500.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='TOP500NL' and lod2 NOT IN ('arterial', 'local')" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/infra_1000.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, original_id, geom FROM visdata.infrastructure_line WHERE original_source='TOP1000NL' and lod2 NOT IN ('arterial', 'local')" -lco COORDINATE_PRECISION=6
