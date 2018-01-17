docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_bgt.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source = 'BGT'"

docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_10.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source='TOP10NL'"

docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_50.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source='TOP50NL'"

docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_100.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source='TOP100NL'"

docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_250.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source='TOP250NL'"

docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_500.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source='TOP500NL'"

docker-compose run --rm gdal ogr2ogr -f GeoJSON /data/urban_1000.geojson -s_srs EPSG:28992 -t_srs EPSG:4326 PG:"host=postgres port=5432 user=DataVIS dbname=DataVIS password=DataVIS" -sql "SELECT * FROM visdata.urban_polygon WHERE original_source='TOP1000NL'"