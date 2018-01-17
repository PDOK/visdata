# -- CREATE MVT 

# -- Select data that intersects with tile area in PostGIS
# -- Scale coordinates to vector tile's coordinates
# -- Clip data to tile area
# -- Encode Vector Tile File
# -- Serve Vector Tile

# BGT
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--no-tile-size-limit --no-line-simplification --no-polygon-splitting  --no-tiny-polygon-reduction \
--output-to-directory=/tiles/visdata_bgt \
--maximum-zoom=17 --minimum-zoom=16 \
--named-layer=admin:/data/admin_10.geojson \
--named-layer=water:/data/water_bgt.geojson \
--named-layer=terrain:/data/terrain_bgt.geojson \
--named-layer=urban:/data/urban_bgt.geojson \
--named-layer=infra:/data/infra_bgt.geojson


#top10
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting \
--output-to-directory=/tiles/visdata_10 \
--maximum-zoom=15 --minimum-zoom=14 \
--named-layer=admin:/data/admin_10.geojson \
--named-layer=water:/data/water_10.geojson \
--named-layer=terrain:/data/terrain_10.geojson \
--named-layer=urban:/data/urban_10.geojson \
--named-layer=infra:/data/infra_10.geojson


#top50
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting  \
--output-to-directory=/tiles/visdata_50 \
--maximum-zoom=13 --minimum-zoom=12 \
--named-layer=admin:/data/admin_50.geojson \
--named-layer=water:/data/water_50.geojson \
--named-layer=terrain:/data/terrain_50.geojson \
--named-layer=urban:/data/urban_50.geojson \
--named-layer=infra:/data/infra_50.geojson

#top100
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --no-polygon-splitting \
--output-to-directory=/tiles/visdata_100 \
--maximum-zoom=11 --minimum-zoom=10 \
--named-layer=admin:/data/admin_100.geojson \
--named-layer=water:/data/water_100.geojson \
--named-layer=terrain:/data/terrain_100.geojson \
--named-layer=urban:/data/urban_100.geojson \
--named-layer=infra:/data/infra_100.geojson

#top250
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --no-tiny-polygon-reduction --no-line-simplification --simplify-only-low-zooms --no-polygon-splitting \
--output-to-directory=/tiles/visdata_250 \
--maximum-zoom=9 --minimum-zoom=8 \
--named-layer=admin:/data/admin_250.geojson \
--named-layer=water:/data/water_250.geojson \
--named-layer=terrain:/data/terrain_250.geojson \
--named-layer=urban:/data/urban_250.geojson \
--named-layer=infra:/data/infra_250.geojson

#top500
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--no-tile-stats --allow-existing --force --coalesce-smallest-as-needed --simplification=5 --drop-smallest-as-needed  --no-polygon-splitting --simplify-only-low-zooms --no-tiny-polygon-reduction  \
--output-to-directory=/tiles/visdata_500 \
--maximum-zoom=7 --minimum-zoom=6 \
--named-layer=admin:/data/admin_500.geojson \
--named-layer=water:/data/water_500.geojson \
--named-layer=terrain:/data/terrain_500.geojson \
--named-layer=urban:/data/urban_500.geojson \
--named-layer=infra:/data/infra_500.geojson

# top1000
docker-compose run --rm  tippecanoe --force --no-tile-stats --no-feature-limit \
--coalesce-smallest-as-needed --simplification=5 --drop-smallest-as-needed  --simplify-only-low-zooms --no-polygon-splitting \
--output-to-directory=/tiles/visdata_1000 \
--maximum-zoom=5 --minimum-zoom=0 \
--named-layer=admin:/data/admin_1000.geojson \
--named-layer=water:/data/water_1000.geojson \
--named-layer=terrain:/data/terrain_1000.geojson \
--named-layer=urban:/data/urban_1000.geojson \
--named-layer=infra:/data/infra_1000.geojson


# -z zoom or --maximum-zoom=zoom: Maxzoom: the highest zoom level for which tiles are generated (default 14)
# -zg or --maximum-zoom=g: Guess what is probably a reasonable maxzoom based on the spacing of features.
# -Z zoom or --minimum-zoom=zoom: Minzoom: the lowest zoom level for which tiles are generated (default 0)


