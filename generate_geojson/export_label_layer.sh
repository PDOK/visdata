ogr2ogr -f GeoJSON /data/geojson/label_bgt.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE original_source='BGT'" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/label_10.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE
	(lod1 = 'residential' AND original_source != 'BGT') 
	OR 
	(lod1 != 'residential'AND original_source = 'TOP10NL')" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/label_50.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE
 ( lod1 = 'residential' AND original_source != 'BGT' AND z_index >= 1) OR 
 ( lod1 = 'water' AND original_source = 'TOP250NL') OR 
 ( lod1 = 'functional' AND original_source = 'TOP50NL') OR 
 ( lod1 = 'natural_areas' AND original_source = 'TOP250NL' )" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/label_100.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE
( lod1 = 'residential' AND original_source != 'BGT' AND z_index >= 10) OR
( lod1 = 'water' AND original_source = 'TOP250NL') OR 
( lod1 = 'functional' AND original_source = 'TOP100NL') OR
( lod1 = 'natural_areas'  AND original_source = 'TOP250NL')" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/label_250.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE
( lod1 = 'residential' AND original_source != 'BGT' AND z_index >= 100) OR
( lod1 != 'residential' AND  original_source = 'TOP250NL') " -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/label_500.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE
(lod1 = 'residential' AND original_source != 'BGT' AND z_index >= 1000 ) OR
(lod1 != 'residential'  AND original_source = 'TOP500NL')" -lco COORDINATE_PRECISION=6

ogr2ogr -f GeoJSON /data/geojson/label_1000.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgis port=5432 user=pdok_owner dbname=visdata password=Ip8pVdIM3eJKzs4aSU1ylfiJaubBRrKu" -sql "SELECT lod1, lod2, name, z_index, rotation, original_id, geom FROM visdata.labels_point WHERE
(lod1 = 'residential' AND original_source != 'BGT' AND z_index >= 100000) 
OR (lod1 != 'residential' AND original_source = 'TOP1000NL')" -lco COORDINATE_PRECISION=6





# BGT  
# original_source = 'BGT'

# TOP10
# voor lod1 = residential alles wat niet BGT is
# voor lod1 != residential alles wat top10nl is


# TOP50
# voor lod1 = residential AND original_source != BGT AND z_index > 10
# voor lod1 = water AND original_source = TOP250
# voor lod1 = functional AND original_source = TOP50
# voor lod1 = natural_areas AND original_source = TOP250 


# TOP100
# voor lod1 = residential AND original_source != BGT AND z_index > 100
# voor lod1 = water AND original_source = TOP250
# voor lod1 = functional AND original_source = TOP100
# voor lod1 = natural_areas AND original_source = TOP250 

# TOP250
# voor lod1 = residential AND original_source != BGT AND z_index > 100
# voor lod1 != residential  original_source = TOP250


# TOP500
# voor lod1 = residential AND original_source != BGT AND z_index > 1000
# voor lod1 != residential  original_source = TOP500

# TOP1000
# voor lod1 = residential AND original_source != BGT AND z_index > 100000
# voor lod1 != residential  original_source = TOP1000
